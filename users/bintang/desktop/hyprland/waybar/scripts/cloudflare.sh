#!/usr/bin/env bash

STATUS=$(pgrep warp-svc)

[[ -n "$STATUS" ]] && echo '󰅟' || echo ''
