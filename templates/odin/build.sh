#!/usr/bin/env bash

PROG_NAME="foobar"
PROG_VERSION="0.1.0"

ARGS=$(cat << EOF
-collection:src=src
-out:build/$PROG_NAME
-build-mode:exe
-vet
-use-separate-modules
-define:PROG_NAME=$PROG_NAME
-define:PROG_VERSION=$PROG_VERSION
EOF
)

if [ ! -r ./build ]; then
    mkdir build
fi

case "$1" in
    "debug")
        odin build src/ $ARGS -debug
        ;;
    "release")
        odin build src/ $ARGS -o:speed
        ;;
    "clean")
        rm -rf build
        ;;
esac
