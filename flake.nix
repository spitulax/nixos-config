{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , hardware
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      lib = nixpkgs.lib // home-manager.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;
      overlays = import ./overlays { inherit inputs outputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Test VM
        "astaroth" = lib.nixosSystem {
          modules = [ ./systems/astaroth ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Test VM
        "bintang@astaroth" = lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/bintang/astaroth.nix ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
