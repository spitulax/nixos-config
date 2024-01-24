{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, hardware, ... }@inputs: 
  let
    inherit (self) outputs;
    system = "x86_64-linux";

    lib = nixpkgs.lib // home-manager.lib;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      # Personal laptop
      "barbatos" = lib.nixosSystem {
        modules = [ ./systems/barbatos ];
        specialArgs = { inherit inputs; };
      };

      # Test VM
      "astaroth" = lib.nixosSystem {
        modules = [ ./systems/astaroth ];
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations = {
      # Personal laptop
      "bintang@barbatos" = lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/bintang/barbatos.nix ];
        extraSpecialArgs = { inherit inputs; };
      };

      # Test VM
      "bintang@astaroth" = lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/bintang/astaroth.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}
