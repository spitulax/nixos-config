{ config
, pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./waybar
    ./font.nix
    ./gtk.nix
    ./qt.nix
    # ./dunst.nix
    ./keymapper.nix
    ./mako.nix
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
