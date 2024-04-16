#!/usr/bin/env bash

TOOLTIP=$(printf "Uptime: %s\\\\n%s\\\\nNixOS %s" \
  "$(uptime | awk '{print $1}' | head -c-4)" \
  "$(uname -sr)" \
  "$(nixos-version)" \
  )
echo '{"text":"","tooltip":'"\"$TOOLTIP\"}"
