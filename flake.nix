{
  description = "My NixOS Configuration";

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system} system);
      pkgsFor = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system});
      pkgs = {
        nixos = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          overlays = [
            inputs.nix-alien.overlays.default
          ] ++ builtins.attrValues outputs.overlays;
        };
        android = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
          overlays = [
            inputs.nix-on-droid.overlays.default
          ] ++ builtins.attrValues outputs.overlays;
        };
      };
    in
    {
      inherit (self) inputs outputs;
      inherit pkgs;

      formatter = forEachSystem (pkgs: _: pkgs.nixpkgs-fmt);
      packages = forEachSystem (pkgs: _: import ./packages { inherit pkgs; });
      checks = forEachSystem (pkgs: system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      });
      devShells = forEachSystem (pkgs: system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              bashInteractive
              gcc
            ];
            shellHook = ''
              ${self.checks.${system}.pre-commit-check.shellHook}
            '';
          };
        });

      overlays = import ./overlays { inherit inputs outputs; };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Personal laptop
        "barbatos" = lib.nixosSystem {
          modules = [ ./hosts/barbatos ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Android on termux
      nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./hosts/dantalion ];
        pkgs = pkgs.android;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      homeConfigurations = {
        # Personal laptop
        "bintang@barbatos" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [ ./users/bintang/barbatos.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-on-droid.url = "github:nix-community/nix-on-droid";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
    nix-on-droid.inputs.home-manager.follows = "home-manager";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";

    nix-alien.url = "github:thiagokokada/nix-alien";
    # Do not modify nix-alien's inputs

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    #############################

    nvchad.url = "github:NvChad/NvChad/v2.0";
    nvchad.flake = false;
  };
}
