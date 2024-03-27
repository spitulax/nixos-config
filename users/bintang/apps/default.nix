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
  ];

  home.packages = with pkgs; [
    krita
    nomacs
  ];
}
