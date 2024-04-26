{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./waybar
    ./mako
    ./rofi
  ];

  home.packages = with pkgs; [
    hyprpicker
    hyprpaper
    inputs.hyprlock.packages.${pkgs.system}.hyprlock
    inputs.hypridle.packages.${pkgs.system}.hypridle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings.env = [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "NIXOS_OZONE_WL,1"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORM,wayland"
      "GDK_BACKEND,wayland"
    ];
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.file = {
    ".config/hypr/catppuccin-mocha.conf".source = ./catppuccin-mocha.conf;
    ".config/hypr/hypridle.conf".source = ./hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  };

  home.file = {
    ".config/hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };

  systemd.user.services.hyprpaper = {
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

  systemd.user.services.hypridle = {
    Unit = {
      Description = "Hypridle";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.meta.getExe inputs.hypridle.packages.${pkgs.system}.hypridle}";
      Restart = "always";
      RestartSec = "10";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
