{ config
, pkgs
, ...
}:
let
  extraConfig = ''
    Shift   >> Shift
    Control >> Control
    AltLeft >> AltLeft
    CapsLock >> Escape
    ContextMenu >> PrintScreen
  '';
in
{
  home.packages = [
    pkgs.mypkgs.keymapper
  ];

  systemd.user.services.keymapper = {
    Unit.Description = "Keymapper";
    Service = {
      ExecStart = "${pkgs.mypkgs.keymapper}/bin/keymapper --no-tray -v -c ${config.xdg.configHome + "/keymapper/keymapper.conf"}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "hyprland-session.target" "graphical-session.target" ];
  };

  xdg.configFile."keymapper/keymapper.conf".text = extraConfig;
}
