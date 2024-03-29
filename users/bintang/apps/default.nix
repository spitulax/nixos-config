{ config
, pkgs
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
    ./dolphin.nix
    ./entries.nix
    ./mime.nix
  ];

  home.packages = with pkgs; [
    krita
    nomacs
  ];
}
