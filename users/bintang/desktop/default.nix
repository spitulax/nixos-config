{ config
, pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./font.nix
    ./gtk.nix
    ./qt.nix
    ./keymapper.nix
  ];

  home.packages = with pkgs; [
    # core
    wl-clipboard
    light
    gnome.zenity

    # for Hyprland
    swaylock
    swayidle
    waybar
    # eww # TODO: Configure eww
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
