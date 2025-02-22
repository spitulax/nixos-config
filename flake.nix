{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";

    # TEMP: kernel
    nixpkgs-temp.url = "github:nixos/nixpkgs/2ff53fe";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid.url = "github:nix-community/nix-on-droid";

    mypkgs.url = "github:spitulax/mypkgs";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    # TEMP: wine
    nix-gaming-temp.url = "github:fufexan/nix-gaming/3030553";

    hyprland.url = "github:hyprwm/Hyprland";

    hyprspace.url = "github:KZDKM/Hyprspace";
    hyprspace.inputs.hyprland.follows = "hyprland";

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # yazi.url = "github:sxyazi/yazi";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #############################

    catppuccin-yazi = {
      url = "github:catppuccin/yazi";
      flake = false;
    };
    catppuccin-zathura = {
      url = "github:catppuccin/zathura";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
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

      configs = import ./flake/configs.nix { inherit myLib lib specialArgs pkgsFor inputs users; };
      vars = import ./flake/vars.nix;
      users = import ./flake/users.nix { inherit myLib; };
      specialArgs = { inherit inputs outputs myLib tempPkgsFor users; };

      myLib = import ./lib { inherit specialArgs lib; };
      lib = nixpkgs.lib // home-manager.lib;

      # Nixpkgs instances per architecture
      systems = [ "x86_64-linux" "aarch64-linux" ];
      genNixpkgs = input: applyOverlays:
        lib.genAttrs systems (system:
          import input {
            inherit system;
            config.allowUnfree = true;
            overlays = lib.optionals applyOverlays (with outputs.overlays; [
              add
              modify
              overlay
            ]);
          }
        );

      # Main nixpkgs
      pkgsFor = genNixpkgs nixpkgs true;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

      # Temporary nixpkgs
      tempPkgsFor = {
        # TEMP: kernel
        kernel = genNixpkgs inputs.nixpkgs-temp false;
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
      packages = forEachSystem (pkgs: import ./packages { inherit pkgs; });
      overlays = import ./overlays { inherit inputs lib myLib outputs tempPkgsFor; };

      # Modules
      nixosConfigModule = ./config/nixos;
      nixosModules = import ./modules/nixos { inherit myLib; };
      homeManagerModules = import ./modules/home-manager { inherit myLib; };

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
