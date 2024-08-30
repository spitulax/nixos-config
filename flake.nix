{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid.url = "github:nix-community/nix-on-droid";

    mypkgs.url = "github:spitulax/mypkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # https://github.com/hyprwm/Hyprland/issues/5891

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";

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
      tempPkgsFor = { };

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
