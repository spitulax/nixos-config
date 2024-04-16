#!/usr/bin/env bash

TOOLTIP=$(printf "Uptime: %s\\\\n%s\\\\nNixOS %s" \
  "$(uptime | awk '{print $3}' | head -c-2)" \
  "$(uname -sr)" \
  "$(nixos-version)" \
  )
echo '{"text":"","tooltip":'"\"$TOOLTIP\"}"
