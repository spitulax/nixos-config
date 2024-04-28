{ writeShellScriptBin }:
writeShellScriptBin "volume" ''

get-volume () {
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

get-mic () {
  if [[ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{ print $3 }') == "[MUTED]" ]]; then
    echo "󰍭  Muted"
  else
    echo "󰍬  Unmuted"
  fi
}

notify-volume () {
  notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Volume" "$(get-volume)" &
}

notify-mic () {
  notify-send -a popup -h string:x-canonical-private-synchronous:sys-notify "Microphone" "$(get-mic)" &
}

case "$1" in
"get")
  get-volume && get-mic
;;
"inc")
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+ && notify-volume
;;
"dec")
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && notify-volume
;;
"toggle")
  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-volume
;;
"toggle-mic")
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && notify-mic
;;
esac

''
