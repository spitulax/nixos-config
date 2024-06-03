package main

import "core:fmt"
import "core:strings"

PROG_NAME :: #config(PROG_NAME, "")
PROG_VERSION :: #config(PROG_VERSION, "")

main :: proc() {
  msg := strings.concatenate({"Hello, ", PROG_NAME, "!, version ", PROG_VERSION})
  defer delete(msg)

  fmt.println(msg)
}

