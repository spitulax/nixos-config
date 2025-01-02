{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.configs.desktop.hyprland.enable {
    home.packages = with pkgs; [
      hyprswitch
    ];

    xdg.configFile = {
      "hyprswitch/style.css".source = ./style.css;
    };
  };
}
