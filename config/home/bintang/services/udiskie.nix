{ config
, lib
, ...
}: {
  options.configs.services.udiskie.enable = lib.mkEnableOption "udiskie" // {
    default = true;
  };

  config = lib.mkIf config.configs.services.udiskie.enable {
    # Automount removable drives
    services.udiskie.enable = true;
  };
}
