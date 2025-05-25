{ config
, lib
, pkgs
, ...
}@inputs:
let
  cfg = config.configs.desktop;
in
{
  imports = [
    ./hyprland
    ./hyprlock
    ./hyprswitch
    ./mako
    ./rofi
    ./waybar
    ./cliphist.nix
    ./easyeffects.nix
    ./gammastep.nix
    ./gtk.nix
    ./kvantum.nix
    ./qt.nix
    ./screenshot.nix
  ];

  options.configs.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      # core
      wl-clipboard # wayland clipboard
      # wtype # wayland xdotool
      brightnessctl
      zenity # GUI from shell scripts

      # notification
      libnotify

      # misc
      alsa-utils
      networkmanagerapplet
      pwvucontrol
      playerctl
      xdragon # drag and drop
    ];

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 36;
    };

    services.playerctld.enable = true;

    systemd.user.services = import ./services inputs;
  };
}
