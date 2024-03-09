{ config
, pkgs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  home.file.".config/hypr/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
