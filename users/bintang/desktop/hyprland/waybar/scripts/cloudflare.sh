#!/usr/bin/env bash

STATUS=$(pgrep warp-svc)

[[ -n "$STATUS" ]] && echo '{"text":"󰅟","tooltip":"Cloudflare warp is on"}' || echo ''
