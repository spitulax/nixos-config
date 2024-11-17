{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.desktop.hyprland;
in
{
  imports = [
    ./mako
    ./rofi
    ./waybar
  ];

  options.configs.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland Wayland compositor";
    monitor = lib.mkOption {
      type = lib.types.str;
      description = "The monitor configuration as defined in <https://wiki.hyprland.org/Configuring/Monitors/>.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpicker
      hyprpaper
      hyprlock
      hyprpolkitagent
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = false;
        variables = [ "--all" ];
      };
      package = pkgs.inputs.hyprland.hyprland;
      settings.env = lib.mapAttrsToList (n: v: n + "," + (toString v)) config.home.sessionVariables ++ [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "NIXOS_OZONE_WL,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland"
      ];
      settings = {
        inherit (cfg) monitor;
      };
      extraConfig = builtins.readFile ./hyprland.conf;
      plugins = [
        pkgs.inputs.hyprspace.Hyprspace
      ];
    };

    home.file = {
      ".config/hypr/catppuccin-mocha.conf".source = ./catppuccin-mocha.conf;
      ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };

    home.file = {
      ".config/hypr/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };
  };
}
