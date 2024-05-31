{ pkgs
, outputs
, lib
, ...
}: {
  nix = {
    package = lib.mkForce pkgs.nix;
    settings = {
      inherit (outputs.vars) substituters trusted-public-keys;
    };
  };
}
