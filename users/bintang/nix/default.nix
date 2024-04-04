{ config
, pkgs
, outputs
, lib
, ...
}: {
  nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      inherit (outputs) substituters trusted-public-keys;
    };
  };
  nixpkgs = {
    inherit (outputs.pkgs.nixos) config overlays;
  };
}
