package main

import "core:fmt"
import "core:mem"
import "core:os"
_ :: mem

PROG_NAME :: #config(PROG_NAME, "")
PROG_VERSION :: #config(PROG_VERSION, "")

start :: proc() -> (ok: bool) {
    fmt.printfln("Hello, ODIN! %s version %s", PROG_NAME, PROG_VERSION)
    return true
}

main :: proc() {
    ok: bool
    defer os.exit(!ok)
    defer free_all(context.temp_allocator)
    when ODIN_DEBUG {
        mem_track: mem.Tracking_Allocator
        mem.tracking_allocator_init(&mem_track, context.allocator)
        context.allocator = mem.tracking_allocator(&mem_track)
        defer {
            fmt.print("\033[1;31m")
            if len(mem_track.allocation_map) > 0 {
                fmt.eprintfln("### %v unfreed allocations ###", len(mem_track.allocation_map))
                for _, v in mem_track.allocation_map {
                    fmt.eprintfln(" -> %v bytes from %v", v.size, v.location)
                }
            }
            if len(mem_track.bad_free_array) > 0 {
                fmt.eprintfln("### %v bad frees ###", len(mem_track.bad_free_array))
                for x in mem_track.bad_free_array {
                    fmt.eprintfln(" -> %p from %v", x.memory, x.location)
                }
            }
            fmt.print("\033[0m")
            mem.tracking_allocator_destroy(&mem_track)
        }
    }

    ok = start()
}

