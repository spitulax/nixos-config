{ config
, pkgs
, ...
}: {
  imports = [
    ./syncthing
    ./udiskie.nix
  ];
}
