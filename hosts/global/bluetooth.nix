{ pkgs
, ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  environment.etc."bluetooth/audio.conf".text = ''
    [General]
    Enable=Source
  '';
}
