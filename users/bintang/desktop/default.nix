{ config
, pkgs
, ...
}: {
  imports = [
    ./font.nix
    ./gtk.nix
  ];

  # @TODO: Move this later
  home.packages = with pkgs; [
    xclip
    wl-clipboard

    brave
    yewtube
    exaile
    keymapper
    zapzap
    libsForQt5.bismuth
  ];
}
