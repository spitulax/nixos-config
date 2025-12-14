# RETIRED
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

    systemd.user.services.hyprswitch = {
      Unit = {
        Description = "Hyprswitch";
        After = "graphical-session.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${lib.meta.getExe pkgs.hyprswitch} init --show-title --size-factor 5 --workspaces-per-row 5 --custom-css ${config.xdg.configHome}/hyprswitch/style.css";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
