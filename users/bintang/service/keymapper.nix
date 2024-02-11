{ config
, pkgs
, outputs
, ...
}: {
  services.keymapper = {
    enable = true;
    extraConfig = ''
      Shift   >> Shift
      Control >> Control
      AltLeft >> AltLeft
      CapsLock >> Escape
      ContextMenu >> PrintScreen
    '';
  };
}
