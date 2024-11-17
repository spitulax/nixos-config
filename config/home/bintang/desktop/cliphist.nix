{ config
, pkgs
, lib
, ...
}: {
  options.configs.desktop.cliphist.enable = lib.mkEnableOption "cliphist";

  config = lib.mkIf config.configs.desktop.cliphist.enable {
    home.packages = [ pkgs.cliphist ];
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
            ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
            Restart = "on-failure";
            Slice = "app-graphical.slice";
          };
        };
        wipe-cliphist = {
          Unit.Description = "Wipe cliphist database";
          Service = {
            Type = "simple";
            ExecStart = "${lib.getExe pkgs.cliphist} wipe";
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
