{ pkgs
, lib
, ...
}:
let
  makeUnitScript = name: text:
    pkgs.writeShellScriptBin "unit-script-${name}" ''
      set -e
      ${text}
    '';

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

  unitScript = makeUnitScript "warn-low-battery" script;
in
{
  systemd.user.services.warn-low-battery = {
    Unit = {
      Description = "Warns user when the battery reaches `services.upower.percentageLow` with `notify-send`";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.meta.getExe unitScript}";
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
