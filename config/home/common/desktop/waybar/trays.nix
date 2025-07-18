{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.waybar;

  genService = exec: {
    Unit = {
      Description = "System tray";
      Requires = [ "tray.target" ];
      After = [ "graphical-session.target" "tray.target" ];
    };
    Service = {
      Type = "exec";
      ExecStart = exec;
      Restart = "on-failure";
      Slice = "background-graphical.slice";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  config = lib.mkIf cfg.enable {
    systemd.user.services = {
      blueman-tray = genService "${pkgs.blueman}/bin/blueman-applet";
      network-manager-tray = genService "${pkgs.networkmanagerapplet}/bin/nm-applet";
    };
  };
}
