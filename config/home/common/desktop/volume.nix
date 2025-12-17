{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.configs.desktop.volume;

  script = pkgs.writeShellScriptBin "volume" ''
    getVolume () {
        VOLUME=$((10#$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $2 }' | sed 's/\.//')))
        STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $3 }')
        if [[ $VOLUME -eq 0 || $STATUS == "[MUTED]" ]]; then
            printf "󰝟"
        elif [[ $VOLUME -lt 33 ]]; then
            printf "󰕿"
        elif [[ $VOLUME -lt 66 ]]; then
            printf "󰖀"
        else
            printf "󰕾"
        fi
        echo "  $VOLUME%"
    }

    getMic () {
        if [[ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{ print $3 }') == "[MUTED]" ]]; then
            echo "󰍭  Muted"
        else
            echo "󰍬  Unmuted"
        fi
    }

    notifyVolume () {
        ${
          if cfg.notify 
          then ''notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Volume" "$(getVolume)" &''
          else ""
        }
    }

    notifyMic () {
        ${
          if cfg.notify 
          then ''notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Microphone" "$(getMic)" &''
          else ""
        }
    }

    case "$1" in
        "get")
            getVolume && getMic
            ;;
        "inc")
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+ && notifyVolume
            ;;
        "dec")
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && notifyVolume
            ;;
        "toggle")
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notifyVolume
            ;;
        "toggle-mic")
            wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notifyMic
            ;;
    esac
  '';
in
{
  options.configs.desktop.volume = {
    enable = lib.mkEnableOption "volume control (wpctl)";
    notify = lib.mkEnableOption "notification";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wireplumber
      pwvucontrol
      alsa-utils
      script
    ];
  };
}
