{ lib
, config
, ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    mkMerge
    mkForce
    ;

  cfg = config.configs.powerManager;
in
{
  options.configs.powerManager = {
    enable = mkEnableOption "Power usage management" // {
      default = true;
    };

    program = mkOption {
      type = types.nullOr (types.enum [
        "auto-cpufreq"
        "power-profiles-daemon"
      ]);
      default = null;
      description = "Which program manages the power usage";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.upower = {
        enable = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
      };
    })

    (mkIf (cfg.enable && cfg.program == "auto-cpufreq") {
      services.auto-cpufreq.enable = true;
      services.tlp.enable = mkForce false;
    })

    (mkIf (cfg.enable && cfg.program == "power-profiles-daemon") {
      services.power-profiles-daemon.enable = true;
    })
  ];
}
