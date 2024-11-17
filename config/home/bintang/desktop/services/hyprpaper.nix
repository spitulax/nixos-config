{ pkgs
, lib
, ...
}: {
  Unit = {
    Description = "Hyprland wallpaper daemon";
    After = "graphical-session.target";
  };
  Service = {
    Type = "exec";
    ExecStart = "${lib.meta.getExe pkgs.hyprpaper}";
    Restart = "on-failure";
    Slice = "background-graphical.slice";
  };
}
