{ config
, lib
, pkgs
, myLib
, ...
}:
let
  cfg = config.configs.desktop;
in
{
  imports = myLib.importIn ./.;

  options.configs.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # core
      wl-clipboard # wayland clipboard
      wtype # wayland xdotool
      brightnessctl
      zenity # GUI from shell scripts
      libsForQt5.polkit-kde-agent # password prompt

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
      xdragon # drag and drop
    ];

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 24;
    };

    services.playerctld.enable = true;
  };
}