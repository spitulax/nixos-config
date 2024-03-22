#!/usr/bin/env bash

TOOLTIP="Do not disturb is"

if [[ "$1" = "show" ]]; then
  if [[ "$(makoctl mode)" = "do-not-disturb" ]]; then
    echo '{"text":"","tooltip":' "\"$TOOLTIP on\"}"
  else
    echo '{"text":"","tooltip":' "\"$TOOLTIP off\"}"
  fi
elif [[ "$1" = "toggle" ]]; then
  [[ "$(makoctl mode)" = "do-not-disturb" ]] && makoctl mode -r do-not-disturb || makoctl mode -s do-not-disturb
fi
