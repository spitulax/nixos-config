{ pkgs
, lib
, ...
}: {
  Unit = {
    Description = "Wayland status bar";
    After = "graphical-session.target";
  };
  Service = {
    Type = "exec";
    ExecStart = "${lib.meta.getExe pkgs.waybar}";
    ExecReload = "${pkgs.util-linux}/bin/kill -SIGUSR2 $MAINPID";
    Restart = "on-failure";
    Slice = "app-graphical.slice";
  };
}
