{ pkgs
, myLib
, ...
}: myLib.importIn ./default // {

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
    mypkgs.gripper

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
    package = pkgs.mypkgs.catppuccin-cursors.mochaBlue;
    name = "catppuccin-mocha-blue-cursors";
    size = 24;
  };

  services.playerctld.enable = true;
}
