{ config
, lib
, pkgs
, ...
}:
let
  script = pkgs.writeShellScriptBin "timeinfo" ''
    time_since_fmt () {
        TIME=$(($(date +%s) - $1))
        TIME_Y=$((10#$(date "+%Y" -d "@$TIME") - 1970))
        TIME_M=$((10#$(date "+%m" -d "@$TIME") - 1))
        TIME_D=$((10#$(date "+%d" -d "@$TIME") - 1))
        TIME_H=$((10#$(date "+%H" -d "@$TIME")))
        TIME_MI=$((10#$(date "+%M" -d "@$TIME")))
        TIME_FULL=$(printf "%sh %smin" "$TIME_H" "$TIME_MI")
        [ $TIME_D -gt 0 ] && TIME_FULL=$(printf "%sd %s" "$TIME_D" "$TIME_FULL")
        [ $TIME_M -gt 0 ] && TIME_FULL=$(printf "%smo %s" "$TIME_M" "$TIME_FULL")
        [ $TIME_Y -gt 0 ] && TIME_FULL=$(printf "%sy %s" "$TIME_Y" "$TIME_FULL")
        echo "$TIME_FULL"
    }

    export TZ='Etc/UTC'

    case "$1" in
        "uptime")
            echo $(time_since_fmt $(cat /proc/stat | grep btime | awk '{print $2}'))
            ;;

        "age")
            echo $(time_since_fmt $(stat -c %W /))
            ;;

        *)
            echo "Usage: $0 <uptime|age>"
            exit 1
            ;;
    esac
  '';
in
{
  options.configs.cli.timeinfo.enable = lib.mkEnableOption "timeinfo";

  config = lib.mkIf config.configs.cli.timeinfo.enable {
    home.packages = [
      script
    ];
  };
}
