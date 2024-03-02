{ config
, outputs
, ...
}: {
  nixpkgs = {
    overlays = builtins.attrValues outputs.homeOverlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
