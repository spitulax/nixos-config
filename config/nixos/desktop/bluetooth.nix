{ config
, lib
, ...
}: {
  config = lib.mkIf config.configs.desktop.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        Policy = {
          AutoEnable = false;
        };
        General = {
          Experimental = true;
        };
      };
    };
    environment.etc."bluetooth/audio.conf".text = ''
      [General]
      Enable=Source
    '';
    services.blueman = {
      enable = true;
      withApplet = false;
    };
  };
}
