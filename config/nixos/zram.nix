{ config
, lib
, ...
}: {
  options.configs.zram.enable = lib.mkEnableOption "zram swap";

  config = lib.mkIf config.configs.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 5;
      memoryPercent = 50;
    };
  };
}
