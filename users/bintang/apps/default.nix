{ config
, pkgs
, ...
}: {
  imports = [
    ./kitty.nix
    ./syncthing.nix
  ];
}
