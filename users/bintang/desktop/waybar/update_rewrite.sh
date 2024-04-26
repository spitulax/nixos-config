#!/usr/bin/env bash

cd "$HOME/.nix-profile/share/applications/"
REWRITE=$(printf '    "rewrite": {')
for f in *.desktop; do
  REWRITE=$(printf "%s\\\\n%s" "$REWRITE" "      \"${f/.desktop/}\": \"$(cat $f | grep '^Name=' | head -n1 | awk -F '=' '{print $2}')\",")
done

# Add custom entries
REWRITE=$(printf "%s\\\\n%s" "$REWRITE" '      "steam": "Steam",')

# Override entries
REWRITE=${REWRITE/'net.lutris.Lutris'/'lutris'}
REWRITE=${REWRITE/'org.nomacs.ImageLounge'/'org.https://nomacs.'}
REWRITE=${REWRITE/'PCSX2'/'pcsx2-qt'}

REWRITE=$(printf "%s\\\\n%s" "$REWRITE" '    },')

printf "$REWRITE\n"
