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

      myLib = import ./lib { inherit (nixpkgs) lib; };
      lib = myLib // nixpkgs.lib // home-manager.lib;

      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system});

      # Nixpkgs instances per architecture
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
      # Expose these to output for easier access
      inherit (self) inputs outputs;
      inherit pkgs lib;

      # Standard flake output
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
      templates = import ./templates { inherit lib; };
      packages = forEachSystem (pkgs: import ./packages { inherit pkgs lib; });
      overlays = import ./overlays { inherit inputs lib; };

      # Modules
      nixosModules = import ./modules/nixos { inherit lib; };
      homeManagerModules = import ./modules/home-manager { inherit lib; };

      # NixOS configs
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

      # Home configs
      homeConfigurations = {
        # Personal laptop
        "bintang@barbatos" = lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [ ./users/bintang/hosts/barbatos ];
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };

      # Binary cache substituters
      substituters = [
        "https://cache.nixos.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-on-droid.cachix.org"
        "https://nix-community.cachix.org"
        "https://spitulax.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "spitulax.cachix.org-1:GQRdtUgc9vwHTkfukneFHFXLPOo0G/2lj2nRw66ENmU="
      ];

    };

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-on-droid.url = "github:nix-community/nix-on-droid";

    mypkgs.url = "github:spitulax/mypkgs";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-alien.url = "github:thiagokokada/nix-alien";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # https://github.com/hyprwm/Hyprland/issues/5891

    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-update.url = "github:nix-community/nixpkgs-update";

    #############################

    nvchad.url = "github:NvChad/NvChad/v2.0";
    nvchad.flake = false;
  };
}
