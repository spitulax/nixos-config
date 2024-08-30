#!/usr/bin/env bash

STATUS=$(warp-cli status | awk 'NR == 1 { print $3 }')
case "$1" in
  "toggle")
    case "$STATUS" in
      "Connected")
        warp-cli disconnect
        sleep 1
      ;;
      *)
        warp-cli connect
        sleep 1
      ;;
    esac
  ;;
  "status")
    case "$STATUS" in
      "Connected")
        echo '{"text":"󰅠","tooltip":"Warp is enabled"}'
      ;;
      *)
        echo '{"text":"󰅟","tooltip":"Warp is disabled"}'
      ;;
    esac
    ;;
esac
