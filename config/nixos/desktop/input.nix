{ config
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    services.libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.4";
        tapping = false;
        middleEmulation = true;
      };
      touchpad = {
        accelProfile = "adaptive";
        accelSpeed = "0.4";
        disableWhileTyping = true;
        naturalScrolling = true;
        tapping = true;
        tappingButtonMap = "lrm";
        tappingDragLock = true;
      };
    };
    services.xserver.xkb = {
      layout = "us";
      variant = "";
      options = "terminate:ctrl_alt_bksp";
    };
  };
}
