#!/usr/bin/env bash

DIR=$(readlink -f "$1")
while
    RESULT=$(find "$DIR"/ -maxdepth 1 "${@:2}")
    [[ -z $RESULT ]] && [[ "$DIR" != "/" ]]
do DIR=$(dirname "$DIR"); done
realpath --relative-to="$1" "$RESULT"
