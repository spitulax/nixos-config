{ pkgs
, ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  environment.etc."bluetooth/audio.conf".text = ''
    [General]
    Enable=Source
  '';
}
