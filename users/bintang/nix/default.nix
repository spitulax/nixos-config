{ config
, pkgs
, outputs
, lib
, ...
}: {
  nixpkgs = {
    overlays = builtins.attrValues outputs.homeOverlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
    };
  };
}