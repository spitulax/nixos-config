{ config
, pkgs
, nixosConfig
, ...
}: {
  imports = [
    ./kitty.nix
    ./browser.nix
    ./zapzap.nix
    ./obs.nix
    ./mpv.nix
    ./entertainment.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    krita
    nomacs
    libsForQt5.dolphin
  ];
}
