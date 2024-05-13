{ pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./mako
    ./rofi
    ./waybar
    ./gammastep
    ./cliphist.nix
    ./kvantum.nix
    ./gtk.nix
    ./qt.nix
    ./keymapper.nix
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # core
    wl-clipboard
    wtype
    brightnessctl
    gnome.zenity
    libsForQt5.polkit-kde-agent

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
    playerctl
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
  };

  services.playerctld.enable = true;
}
