{ config
, pkgs
, ...
}: {
  imports = [
    ./keyboard.nix
    ./env.nix
    ./sops.nix
  ];
}
