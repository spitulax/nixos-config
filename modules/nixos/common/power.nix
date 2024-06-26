{ lib
, config
, inputs
, ...
}:
let
  cfg = config.power.power-manager;
in
with lib; {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  options.power.power-manager = {
    enable = mkEnableOption "Power usage management";

    program = mkOption {
      type = types.nullOr (types.enum [
        "auto-cpufreq"
        "power-profiles-daemon"
      ]);
      description = "Which program manages the power usage";
    };
  };

  config = mkIf cfg.enable {
    services.upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;
      percentageAction = 5;
    };

    programs.auto-cpufreq.enable = cfg.program == "auto-cpufreq";
    services.power-profiles-daemon.enable = cfg.program == "power-profiles-daemon";
  };
}
