{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./misc
    ./cli
    ./nvim
    ./syncthing
  ];

  home = {
    username = "bintang";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11";
  };

  # Fix DPI
  xresources.properties = {
    "Xft.dpi" = 105;
  };
}
