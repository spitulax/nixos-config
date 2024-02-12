{ config
, pkgs
, ...
}: {
  imports = [
    ./kitty.nix
    ./zapzap.nix
  ];

  home.packages = with pkgs; [
    brave
    yewtube
    exaile
    zapzap
  ];
}
