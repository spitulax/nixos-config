{ config
, lib
, pkgs
, ...
}: {
  options.configs.services.udiskie.enable = lib.mkEnableOption "udiskie" // {
    default = true;
  };

  config = lib.mkIf config.configs.services.udiskie.enable {
    # Automount removable drives
    home.packages = with pkgs; [
      udiskie
    ];
    services.udiskie.enable = true;
  };
}
