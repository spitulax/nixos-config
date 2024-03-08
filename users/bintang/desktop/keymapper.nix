{ config
, pkgs
, outputs
, ...
}: {
  services.keymapper = {
    enable = true;
    systemdTarget = [ "hyprland-session.target" "graphical-session.target" ];
    extraConfig = ''
      Shift   >> Shift
      Control >> Control
      AltLeft >> AltLeft
      CapsLock >> Escape
      ContextMenu >> PrintScreen
    '';
  };
}
