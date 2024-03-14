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
    pixelorama
    krita
    webcamoid
    nomacs
    libsForQt5.dolphin
  ];
}
