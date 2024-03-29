{ config
, pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./kvantum.nix
    ./gtk.nix
    ./qt.nix
    ./keymapper.nix
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # core
    wl-clipboard
    cliphist
    brightnessctl
    gnome.zenity
    libsForQt5.polkit-kde-agent

    # for Hyprland
    swaylock
    swayidle
    swww
    rofi-wayland
    rofimoji

    # screenshot
    grim
    slurp

    # notification
    mako
    libnotify

    # misc
    alsa-utils
    networkmanagerapplet
    pavucontrol
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };
}
