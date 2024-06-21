{ pkgs
, config
, lib
, inputs
, ...
}: {
  imports = [
    ./hyprland/ags
    ./hyprland/mako
    ./hyprland/rofi
    ./hyprland/waybar
  ];

  home.packages = with pkgs; [
    hyprpicker
    hyprpaper
    mypkgs.hyprlock
    # inputs.hypridle.packages.${pkgs.system}.hypridle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings.env = lib.mapAttrsToList (n: v: n + "," + (toString v)) config.home.sessionVariables ++ [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "NIXOS_OZONE_WL,1"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORM,wayland"
      "GDK_BACKEND,wayland"
    ];
    extraConfig = builtins.readFile ./hyprland/hyprland.conf;
  };

  home.file = {
    ".config/hypr/catppuccin-mocha.conf".source = ./hyprland/catppuccin-mocha.conf;
    # ".config/hypr/hypridle.conf".source = ./hyprland/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprland/hyprlock.conf;
  };

  home.file = {
    ".config/hypr/scripts" = {
      source = ./hyprland/scripts;
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

  # systemd.user.services.hypridle = {
  #   Unit = {
  #     Description = "Hypridle";
  #     After = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${lib.meta.getExe inputs.hypridle.packages.${pkgs.system}.hypridle}";
  #     Restart = "always";
  #     RestartSec = "10";
  #   };
  #   Install.WantedBy = [ "default.target" ];
  # };
}
