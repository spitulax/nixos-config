{ config
, lib
, ...
}: {
  options.configs.tablet.enable = lib.mkEnableOption "tablet driver";

  config = lib.mkIf config.configs.tablet.enable {
    hardware.opentabletdriver.enable = true;
  };
}
