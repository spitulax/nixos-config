{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";

    # TEMP: https://github.com/NixOS/nixpkgs/pull/438958
    nixpkgs-anki-fix.url = "github:nixos/nixpkgs/fbcf476f790d8a217c3eab4e12033dc4a0f6d23c";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mypkgs.url = "github:spitulax/mypkgs";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "github:hyprwm/Hyprland";

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      # TEMP: urwid<3.0.0,>=2.6.16 not satisfied by version 3.0.2
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # yazi.url = "github:sxyazi/yazi";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #############################

    rose-pine-kitty = {
      url = "github:rose-pine/kitty";
      flake = false;
    };
    rose-pine-btop = {
      url = "github:rose-pine/btop";
      flake = false;
    };

    #############################

    # TEMP: These are here until I can override flakes in mypkgs

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      commonArgs = {
        inherit (self) inputs outputs;
        inherit pkgsFor tempPkgsFor myLib lib;
        inherit configs specialArgs vars users;
      };

      configs = import ./flake/configs.nix commonArgs;
      vars = import ./flake/vars.nix;
      users = import ./flake/users.nix commonArgs;
      specialArgs = { inherit inputs outputs myLib tempPkgsFor users; };

      myLibBase = import ./lib { inherit lib; };
      myLibExtra = import ./lib/extra.nix commonArgs;
      myLib = myLibBase // myLibExtra;
      inherit (nixpkgs) lib;

      # Nixpkgs instances per architecture
      systems = [ "x86_64-linux" ];
      genNixpkgs = input: applyOverlays:
        lib.genAttrs systems (system:
          import input {
            inherit system;
            config.allowUnfree = true;
            overlays = lib.optionals applyOverlays [
              outputs.overlays.default
            ];
          }
        );

      # Main nixpkgs
      pkgsFor = genNixpkgs nixpkgs true;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      # Temporary nixpkgs
      tempPkgsFor = {
        anki = genNixpkgs inputs.nixpkgs-anki-fix false;
      };

      # Allow easy config access by exporting "nixos-${hostname}" and "home-${username}-${hostname}" to flake output
      replConfigShortcuts =
        (lib.mapAttrs'
          (n: lib.nameValuePair ("nixos-" + n))
          (lib.mapAttrs
            (k: v: configs.nixosConfigurations.${k}.config)
            configs.nixosConfigurations))
        //
        (lib.mapAttrs'
          (n: lib.nameValuePair ("home-" + lib.concatStringsSep "-" (lib.splitString "@" n)))
          (lib.mapAttrs
            (k: v: configs.homeConfigurations.${k}.config)
            configs.homeConfigurations));
    in
    {
      # Standard flake output
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);
      packages = forEachSystem (pkgs: import ./packages { inherit pkgs; });
      overlays = import ./overlays { inherit inputs lib myLib outputs tempPkgsFor; };

      # Modules
      nixosConfigModule = ./config/nixos;
      nixosModules = import ./modules/nixos { inherit myLib; };
      homeManagerModules = import ./modules/home-manager { inherit myLib; };

      # Configs
      inherit (configs)
        nixosConfigurations
        homeConfigurations;

    }
    # Expose these to output for easier access
    // commonArgs
    // replConfigShortcuts;
}
