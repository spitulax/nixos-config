#!/usr/bin/env bash

if [[ $# -ne 2 ]]; then
    echo "$0 <ssid> <password>" >&2
    exit 1
fi

SSID=$1
PASSWORD=$2

nmcli r wifi off
rfkill unblock wlan
sudo lnxrouter --ap wlp1s0 "$SSID" -p "$PASSWORD" --qr
