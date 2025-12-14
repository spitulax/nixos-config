{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.brightness;

  script = pkgs.writeShellScriptBin "brightness" ''
    get () {
        BRIGHTNESS=$(brightnessctl info | awk 'NR==2 { print $4 }' | sed -r 's/\((.*)%\)/\1/')
        if [ $BRIGHTNESS -lt 25 ]; then
            printf "󰃞"
        elif [ $BRIGHTNESS -lt 50 ]; then
            printf "󰃟"
        elif [ $BRIGHTNESS -lt 75 ]; then
            printf "󰃝"
        else
            printf "󰃠"
        fi
        echo "  $BRIGHTNESS%"
    }

    notify () {
        notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Brightness" "$(get)" &
    }

    case "$1" in
        "get")
            get
            ;;
        "inc")
            brightnessctl set 5%+ && notify
            ;;
        "dec")
            brightnessctl set 5%- && notify
            ;;
    esac
  '';
in
{
  options.configs.desktop.brightness.enable = lib.mkEnableOption "brightness control (brightnessctl)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
      script
    ];
  };
}
