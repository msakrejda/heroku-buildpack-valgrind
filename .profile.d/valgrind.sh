#!/bin/bash

# Can't use an alias since this runs in a non-interactive shell, so
# wrap in a shell function
function valgrind() {
    PATH=/app/.valgrind/install/bin:$PATH /app/.valgrind/install/bin/valgrind --extra-debuginfo-path=/app/.valgrind/libc6-dbg/usr/lib/debug "$@"
}

export -f valgrind
