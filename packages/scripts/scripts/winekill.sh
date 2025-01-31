#!/usr/bin/env bash

set -eu pipefail

PIDS=($(ps ax -o pid,comm | grep -i '\.exe$' | awk '{ print $1 }' | tr '\n' ' '))
NAMES=()
for pid in ${PIDS[@]}; do
    NAMES+=("$(ps -o comm "$pid" | tail -n1)")
done

if [ ${#PIDS[@]} -le 0 ]; then
    echo "No process to kill" 1>&2
    exit 1
fi

if kill -KILL ${PIDS[@]}; then
    echo "Killed:"
    for n in "${NAMES[@]}"; do
        echo "$n"
    done
else
    echo "Failed to kill ${PIDS[@]}" 1>&2
fi
