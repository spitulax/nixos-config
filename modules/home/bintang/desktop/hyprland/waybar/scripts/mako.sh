#!/usr/bin/env bash

if [[ "$1" = "show" ]]; then
  if [[ "$(makoctl mode)" = "do-not-disturb" ]]; then
    echo '{"text":"","tooltip":"Do not disturb is on"}'
  else
    echo '{"text":"","tooltip":"Do not disturb is off"}'
  fi
elif [[ "$1" = "toggle" ]]; then
  [[ "$(makoctl mode)" = "do-not-disturb" ]] && makoctl mode -r do-not-disturb || makoctl mode -s do-not-disturb
fi
