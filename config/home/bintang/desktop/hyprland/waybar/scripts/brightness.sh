#!/usr/bin/env bash

TEXT=$(brightness get | awk '{print $1}')
TOOLTIP=$(brightness get | awk '{print $2}')
printf '{"text":"%s","tooltip":"Brightness: %s"}' "$TEXT" "$TOOLTIP"
