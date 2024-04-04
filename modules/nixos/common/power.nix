{ inputs
, lib
, config
, ...
}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  options.power.power-profiles-daemon.enable = lib.mkEnableOption "power-profiles-daemon";

  config = {
    programs.auto-cpufreq.enable = !config.power.power-profiles-daemon.enable;

    services = {
      power-profiles-daemon = {
        inherit (config.power.power-profiles-daemon) enable;
      };
      upower = {
        enable = true;
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
      };
    };
  };
}
