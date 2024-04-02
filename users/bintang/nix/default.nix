{ config
, pkgs
, outputs
, lib
, ...
}: {
  nix = {
    package = lib.mkForce pkgs.nix;
  };
  nixpkgs = {
    inherit (outputs.pkgs.nixos) config overlays;
  };
}
