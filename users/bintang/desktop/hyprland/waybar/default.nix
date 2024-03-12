{ config
, pkgs
, ...
}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
  };

  home.file = {
    ".config/waybar/config.jsonc".source = ./config.jsonc;
    ".config/waybar/style.css".source = ./style.css;
    ".config/waybar/catppuccin-mocha.css".source = ./catppuccin-mocha.css;
  };
}
