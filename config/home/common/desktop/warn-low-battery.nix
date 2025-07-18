{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.warn-low-battery;

  # NOTREALLYIMPORTANT: BAT0 is harcoded
  script = ''
    HAS_SENT=0
    while :; do
      WARNING=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -e 'warning-level:' | awk '{print $2}')
      if [ "$WARNING" = "low" ] && [ $HAS_SENT -eq 0 ]; then
        notify-send -u critical "󱟟 Battery is Low"
        HAS_SENT=1
      elif [ "$WARNING" != "low" ] && [ $HAS_SENT -eq 1 ]; then
        HAS_SENT=0
      fi
      sleep 10
    done
  '';

  unitScript = pkgs.makeUnitScript "warn-low-battery" script;
in
{
  options.configs.desktop.warn-low-battery.enable = lib.mkEnableOption "warning on low battery with notification daemon";

  config = lib.mkIf cfg.enable {
    systemd.user.services.warn-low-battery = {
      Unit = {
        Description = "Warns user when the battery reaches `services.upower.percentageLow` with `notify-send`";
        After = "graphical-session.target";
      };
      Service = {
        Type = "exec";
        ExecStart = "${lib.meta.getExe unitScript}";
        Restart = "always";
        Slice = "background-graphical.slice";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
