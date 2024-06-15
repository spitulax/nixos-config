package main

import "core:fmt"

PROG_NAME :: #config(PROG_NAME, "")
PROG_VERSION :: #config(PROG_VERSION, "")

main :: proc() {
    fmt.printfln("Hello, ODIN! %s version %s", PROG_NAME, PROG_VERSION)
}
