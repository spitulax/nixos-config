{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.hyprland.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.mypkgs.waybar;
    };

    xdg.configFile = {
      "waybar/config.jsonc".source = ./config.jsonc;
      "waybar/style.css".source = ./style.css;
      "waybar/catppuccin-mocha.css".source = ./catppuccin-mocha.css;
      "waybar/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };
  };
}
