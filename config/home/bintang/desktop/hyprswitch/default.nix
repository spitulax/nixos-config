{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.hyprswitch;
in
{
  options.configs.desktop.hyprswitch = {
    enable = lib.mkEnableOption "Hyprswitch";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprswitch
    ];

    xdg.configFile = {
      "hyprswitch/style.css".source = ./style.css;
    };
  };
}
