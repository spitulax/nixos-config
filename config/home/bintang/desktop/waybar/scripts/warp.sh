#!/usr/bin/env bash

STATUS=$(warp-cli status | grep 'Status update:' | awk '{ print $3 }')
case "$1" in
    "toggle")
        case "$STATUS" in
            "Connected" | "Connecting")
                warp-cli disconnect
                ;;
            *)
                warp-cli connect
                ;;
        esac
        ;;
    "status")
        case "$STATUS" in
            "Connected" | "Connecting")
                echo '{"text":"󰅠","tooltip":"Warp is enabled"}'
                ;;
            *)
                echo '{"text":"󰅟","tooltip":"Warp is disabled"}'
                ;;
        esac
        ;;
esac
