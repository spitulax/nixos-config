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

    mypkgs = {
      url = "./mypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #############################

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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
        inherit configs vars users;
        inherit specialArgs myArgs;
      };

      configs = import ./flake/configs.nix commonArgs;
      vars = import ./flake/vars.nix;
      users = import ./flake/users.nix commonArgs;

      # Use `specialArgs` if the value will be referenced in imports, otherwise prefer `myArgs`.
      specialArgs = {
        inherit inputs users;
        inherit (outputs) nixosModules homeManagerModules;
        myLib = myLibBase;
      };
      myArgs = {
        inherit tempPkgsFor vars;
        inherit (outputs) nixosConfigurations;
      };
      myArgsOverlay = _: _: {
        inherit myArgs;
      };

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
              myArgsOverlay
            ];
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
      overlays = import ./overlays commonArgs;
      devShells = forEachSystem (pkgs: {
        default = import ./flake/shell.nix { inherit pkgs; };
      });

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
