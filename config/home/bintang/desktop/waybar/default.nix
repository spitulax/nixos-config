{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.waybar;
in
{
  options.configs.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
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
