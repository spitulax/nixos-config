{ config
, pkgs
, ...
}: {
  imports = [
    ./kitty.nix
    ./zapzap.nix
    ./elisa.nix
  ];

  home.packages = with pkgs; [
    brave
    yewtube
    zapzap
  ];
}
