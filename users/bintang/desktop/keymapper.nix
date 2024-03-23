{ config
, pkgs
, outputs
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
    pkgs.keymapper
  ];

  systemd.user.services.keymapper = {
    Unit = {
      X-SwitchMethod = "restart";
      X-ConfigHash = builtins.hashString "md5" extraConfig;
      Description = "Keymapper";
    };
    Service = {
      ExecStart = "${pkgs.keymapper}/bin/keymapper -v -c ${config.xdg.configHome + "/keymapper/keymapper.conf"}";
      Restart = "always";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "hyprland-session.target" "graphical-session.target" ];
    };
  };

  xdg.configFile."keymapper/keymapper.conf".text = extraConfig;
}
