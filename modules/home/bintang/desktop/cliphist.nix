{ pkgs
, lib
, ...
}: {
  home.packages = [ pkgs.cliphist ];
  systemd.user = {
    services.wipe-cliphist = {
      Unit.Description = "Wipe cliphist database";
      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.cliphist} wipe";
      };
      Install.WantedBy = [ "multi-user.target" ];
    };
    timers.wipe-cliphist = {
      Timer = {
        Unit = "wipe-cliphist.service";
        OnStartupSec = "0";
        OnUnitActiveSec = "12h";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
