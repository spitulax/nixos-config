{ writeShellScriptBin }:
writeShellScriptBin "reminder" ''

if [ $# -eq 2 ]; then
  while :; do
    if [ "$(date '+%R')" = $1 ]; then
      notify-send -u critical $2
      break
    fi
    sleep 1
  done
else
  echo 'Usage: reminder <HH:MM> <message>'
  exit 1
fi

''
