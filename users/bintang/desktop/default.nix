{ config
, pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./eww
    ./gtk.nix
    ./qt.nix
    ./keymapper.nix
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # core
    wl-clipboard
    light
    gnome.zenity

    # for Hyprland
    swaylock
    swayidle
    eww
    wlogout
    swww
    rofi-wayland
    rofimoji

    # screenshot
    flameshot
    grim
    slurp

    # notification
    mako
    libnotify

    # misc
    alsa-utils
    networkmanagerapplet
    keymapper
  ];
}
