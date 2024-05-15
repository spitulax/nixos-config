{ inputs
, outputs
, myLib
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = false;
    extraSpecialArgs = { inherit inputs outputs myLib; };
  };
}
