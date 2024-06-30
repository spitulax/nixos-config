{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-temp.url = "github:nixos/nixpkgs/2893f56de08021cffd9b6b6dfc70fd9ccd51eb60";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-on-droid.url = "github:nix-community/nix-on-droid";

    mypkgs.url = "github:spitulax/mypkgs";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # https://github.com/hyprwm/Hyprland/issues/5891

    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";

    #############################
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      configs = import ./flake/configs.nix { inherit lib specialArgs pkgsFor inputs; };
      vars = import ./flake/vars.nix;

      myLib = import ./lib { inherit (nixpkgs) lib; };
      lib = nixpkgs.lib // home-manager.lib;
      specialArgs = { inherit inputs outputs myLib tempPkgsFor; };

      # Nixpkgs instances per architecture
      systems = [ "x86_64-linux" "aarch64-linux" ];
      genNixpkgs = input: overlay:
        lib.genAttrs systems (system:
          import input {
            inherit system;
            config.allowUnfree = true;
            overlays = lib.optionals overlay (with outputs.overlays; [
              add
              modify
            ]);
          }
        );

      # Main nixpkgs
      pkgsFor = genNixpkgs nixpkgs true;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      # Temporary nixpkgs
      tempPkgsFor = {
        spotdl = genNixpkgs inputs.nixpkgs-temp false;
      };

      # Allow easy config access by exporting "nixos-${hostname}" and "home-${username}-${hostname}" to flake output
      replConfigShortcuts =
        (lib.mapAttrs'
          (n: lib.nameValuePair ("nixos-" + n))
          (lib.genAttrs
            (builtins.attrNames configs.nixosConfigurations)
            (name: configs.nixosConfigurations.${name}.config)))
        //
        (lib.mapAttrs'
          (n: lib.nameValuePair ("home-" + lib.concatStringsSep "-" (lib.splitString "@" n)))
          (lib.genAttrs
            (builtins.attrNames configs.homeConfigurations)
            (name: configs.homeConfigurations.${name}.config)));
    in
    {
      # Standard flake output
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
      templates = import ./templates { inherit myLib; };
      packages = forEachSystem (pkgs: import ./packages { inherit pkgs lib myLib; });
      overlays = import ./overlays { inherit inputs lib outputs; };

      # Modules
      nixosModules = import ./modules/nixos { inherit myLib; };
      homeManagerModules = import ./modules/home-manager { inherit myLib; };
      homeModules = myLib.genAttrsEachDirs ./modules/home (n: import ./modules/home/${n} { inherit myLib; });

      # Configs
      inherit (configs)
        nixosConfigurations
        nixOnDroidConfigurations
        homeConfigurations;

      # Expose these to output for easier access
      inherit (self) inputs outputs;
      inherit pkgsFor tempPkgsFor myLib lib;
      inherit specialArgs;
      inherit vars;
    }
    // replConfigShortcuts;
}
