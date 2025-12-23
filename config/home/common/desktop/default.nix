{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop;
in
{
  imports = [
    ./hyprland
    ./hyprlock
    # ./hyprswitch
    ./mako
    ./rofi
    ./sway
    ./tofi
    ./waybar
    ./brightness.nix
    ./cliphist.nix
    ./easyeffects.nix
    ./gammastep.nix
    ./gtk.nix
    ./kvantum.nix
    ./qt.nix
    ./screenshot.nix
    ./udiskie.nix
    ./volume.nix
    ./warn-low-battery.nix
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
      zenity # GUI from shell scripts

      # misc
      networkmanagerapplet
      playerctl
      dragon-drop # drag and drop
    ];

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.whitesur-cursors;
      name = "WhiteSur-cursors";
      size = 36;
    };

    services.playerctld.enable = true;
  };
}
