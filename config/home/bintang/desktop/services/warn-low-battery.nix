{ pkgs
, lib
, ...
}:
let
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
}
