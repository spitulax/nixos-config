{ config
, lib
, ...
}:
let
  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    types
    ;

  cfg = config.configs.desktop.gammastep;
in
{
  options.configs.desktop.gammastep = {
    enable = mkEnableOption "Gammastep";
    temperature = {
      day = mkOption {
        type = types.int;
        default = 6500;
        description = "Monitor temperature at daytime";
      };
      night = mkOption {
        type = types.int;
        default = 5000;
        description = "Monitor temperature at nighttime";
      };
    };
  };

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      tray = true;
      dawnTime = "4:30-6:00";
      duskTime = "17:30-19:00";
      inherit (cfg) temperature;
    };
  };
}
