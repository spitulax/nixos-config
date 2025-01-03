{ pkgs
, lib
, config
, ...
}: {
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
}
