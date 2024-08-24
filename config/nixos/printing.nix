{ config
, lib
, ...
}: {
  options.configs.printing.enable = lib.mkEnableOption "printing services";

  config = lib.mkIf config.configs.printing.enable {
    services.printing.enable = true;
  };
}
