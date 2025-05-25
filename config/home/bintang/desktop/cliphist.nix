{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.configs.desktop.cliphist;

  package = pkgs.cliphist;
in
{
  options.configs.desktop.cliphist.enable = lib.mkEnableOption "cliphist";

  config = lib.mkIf cfg.enable {
    home.packages = [ package ];
    systemd.user = {
      services = {
        cliphist = {
          Unit = {
            Description = "Clipboard history manager for Wayland";
            After = "graphical-session.target";
            Before = "wipe-cliphist.timer";
            Wants = "wipe-cliphist.timer";
          };
          Service = {
            Type = "exec";
            ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe package} store";
            Restart = "on-failure";
            Slice = "app-graphical.slice";
          };
          Install.WantedBy = [ "graphical-session.target" ];
        };
        wipe-cliphist = {
          Unit.Description = "Wipe cliphist database";
          Service = {
            Type = "simple";
            ExecStart = "${lib.getExe package} wipe";
          };
        };
      };
      timers.wipe-cliphist = {
        Timer = {
          Unit = "wipe-cliphist.service";
          OnStartupSec = "0";
          OnUnitActiveSec = "12h";
        };
      };
    };
  };
}
