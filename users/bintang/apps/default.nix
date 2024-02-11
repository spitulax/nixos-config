{ config
, pkgs
, ...
}: {
  imports = [
    ./kitty.nix
    ./syncthing.nix
    ./zapzap.nix
  ];

  home.packages = with pkgs; [
    brave
    yewtube
    exaile
    zapzap
  ];
}
