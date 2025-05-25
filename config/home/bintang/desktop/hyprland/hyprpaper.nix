{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.hyprland;

  inherit (lib)
    mkIf
    ;

  package = pkgs.hyprpaper;
in
{
  config = mkIf cfg.enable {
    home.packages = [
      package
    ];

    systemd.user.services.hyprpaper = {
      Unit = {
        Description = "Hyprland wallpaper daemon";
        After = "graphical-session.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${lib.meta.getExe package}";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
