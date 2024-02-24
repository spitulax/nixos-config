{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nvchad.url = "github:spitulax/nix-NvChad";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nh.url = "github:viperML/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
  };

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
      formatter.${system} = pkgs.nixpkgs-fmt;
      overlays = import ./overlays { inherit inputs outputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        # Personal laptop
        "barbatos" = lib.nixosSystem {
          modules = [ ./systems/barbatos ];
          specialArgs = { inherit inputs outputs; };
        };

        # Test VM
        # "astaroth" = lib.nixosSystem {
        #   modules = [ ./systems/astaroth ];
        #   specialArgs = { inherit inputs outputs; };
        # };
      };

      homeConfigurations = {
        # Personal laptop
        "bintang@barbatos" = lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/bintang/barbatos.nix ];
          extraSpecialArgs = {
            inherit inputs outputs;
            nixosConfig = outputs.nixosConfigurations."barbatos".config;
          };
        };

        # Test VM
        # "bintang@astaroth" = lib.homeManagerConfiguration {
        #   inherit pkgs;
        #   modules = [ ./users/bintang/astaroth.nix ];
        #   extraSpecialArgs = { inherit inputs outputs; };
        # };
      };
    };
}
