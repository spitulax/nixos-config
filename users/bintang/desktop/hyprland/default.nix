{ config
, pkgs
, ...
}: {
  imports = [
    ./waybar
    ./mako
  ];

  home.packages = with pkgs; [
    hyprpicker
    hypridle
    hyprlock
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings.env = [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "NIXOS_OZONE_WL,1"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORM,wayland"
      "SDL_VIDEODRIVER,wayland"
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
}
