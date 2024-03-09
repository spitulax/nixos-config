{ pkgs
, ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      Policy = {
        AutoEnable = false;
      };
    };
  };
  environment.etc."bluetooth/audio.conf".text = ''
    [General]
    Enable=Source
  '';
  services.blueman.enable = true;
}
