{ pkgs
, lib
, config
, ...
}:
let
  inherit (config.configs.env) defaultPrograms;
in
{
  Unit = {
    Description = "udiskie mount daemon";
    After = "graphical-session.target";
  };
  Service = {
    Type = "exec";
    ExecStart = lib.escapeShellArgs [
      "${pkgs.udiskie}/bin/udiskie"
      "-s"
      "-a"
      "-n"
      "-m"
      "flat"
      "--appindicator"
      "-f"
      defaultPrograms.fileManager
      "--terminal"
      defaultPrograms.terminal
    ];
    Restart = "on-failure";
    Slice = "background-graphical.slice";
  };
}
