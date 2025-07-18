{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.udiskie;

  inherit (config.configs.env) defaultPrograms;

  package = pkgs.udiskie;
in
{
  options.configs.desktop.udiskie.enable = lib.mkEnableOption "udiskie";

  config = lib.mkIf cfg.enable {
    home.packages = [
      package
    ];

    systemd.user.services.udiskie = {
      Unit = {
        Description = "udiskie mount daemon";
        After = "graphical-session.target";
      };
      Service = {
        Type = "exec";
        ExecStart = lib.escapeShellArgs [
          "${package}/bin/udiskie"
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
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
