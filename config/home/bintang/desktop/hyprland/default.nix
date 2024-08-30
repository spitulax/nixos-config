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
      mypkgs.hyprlock
      # hypridle
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
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
        bind = "CTRL ALT, Escape, exec, hyprctl reload && hyprctl keyword monitor ${cfg.monitor}";
      };
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    home.file = {
      ".config/hypr/catppuccin-mocha.conf".source = ./catppuccin-mocha.conf;
      # ".config/hypr/hypridle.conf".source = ./hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };

    home.file = {
      ".config/hypr/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };

    systemd.user.services = {
      hyprpaper = {
        Unit = {
          Description = "Hyprland wallpaper daemon";
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${lib.meta.getExe pkgs.hyprpaper}";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "hyprland-session.target" ];
      };

      warn-low-battery = import ./warn-low-battery.nix { inherit pkgs lib; };
    };

    # systemd.user.services.hypridle = {
    #   Unit = {
    #     Description = "Hypridle";
    #     After = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${lib.meta.getExe pkgs.hypridle}";
    #     Restart = "always";
    #     RestartSec = "10";
    #   };
    #   Install.WantedBy = [ "default.target" ];
    # };
  };
}
