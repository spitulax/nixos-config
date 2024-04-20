#!/usr/bin/env bash

export TZ='Etc/UTC'
UPTIME=$(echo $(($(date +%s) - $(cat /proc/stat | grep btime | awk '{print $2}'))))
UPTIME_Y=$((10#$(date "+%Y" -d "@$UPTIME") - 1970))
UPTIME_M=$((10#$(date "+%m" -d "@$UPTIME") - 1))
UPTIME_D=$((10#$(date "+%d" -d "@$UPTIME") - 1))
UPTIME_H=$((10#$(date "+%H" -d "@$UPTIME")))
UPTIME_MI=$((10#$(date "+%M" -d "@$UPTIME")))
UPTIME_FULL=$(printf "%sh %smin" "$UPTIME_H" "$UPTIME_MI")
if [[ $UPTIME_Y > 0 ]]; then
  UPTIME_FULL=$(printf "%sy %smo %sd %s" "$UPTIME_Y" "$UPTIME_M" "$UPTIME_D" "$UPTIME_FULL")
elif [[ $UPTIME_M > 0 ]]; then
  UPTIME_FULL=$(printf "%smo %sd %s" "$UPTIME_M" "$UPTIME_D" "$UPTIME_FULL")
elif [[ $UPTIME_D > 0 ]]; then
  UPTIME_FULL=$(printf "%sd %s" "$UPTIME_D" "$UPTIME_FULL")
fi

TOOLTIP=$(printf "Uptime %s\\\\nLinux  %s\\\\nNixOS  %s" \
  "$UPTIME_FULL" \
  "$(uname -r)" \
  "$(nixos-version)" \
  )
echo '{"text":"","tooltip":'"\"$TOOLTIP\"}"
