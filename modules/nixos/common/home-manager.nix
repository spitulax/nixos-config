{ inputs
, outputs
, ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useGlobalPkgs = false;
    extraSpecialArgs = outputs.specialArgs;
  };
}
