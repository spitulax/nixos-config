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
      system = "x86_64-linux";

      lib = nixpkgs.lib // home-manager.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      inherit (self) inputs outputs;
      formatter.${system} = pkgs.nixpkgs-fmt;
      packages.${system} = import ./packages { inherit pkgs; }; # build with `nix build`. these packages also get added to nixpkgs overlay
      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };
      devShells.${system} =
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
        };

      overlays = import ./overlays { inherit inputs outputs; };
      nixpkgsOverlays = [
        inputs.nix-alien.overlays.default
      ] ++ (builtins.attrValues outputs.overlays);

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Personal laptop
        "barbatos" = lib.nixosSystem {
          modules = [ ./hosts/barbatos ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Personal laptop
        "bintang@barbatos" = lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/bintang/barbatos.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
            nixosConfig = outputs.nixosConfigurations."barbatos";
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
