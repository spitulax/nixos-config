{ config
, pkgs
, ...
}: {
  imports = [
    ./font.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    xclip
    wl-clipboard
    libsForQt5.kdialog
    swaylock
    waybar
    # eww # TODO: Configure eww
    # dunst
    mako
    libnotify
    swww
    rofi-wayland
    rofimoji
    flameshot
    grim
    slurp
  ];
}
