#!/bin/bash

export PATH=/app/.valgrind/install/bin:$PATH
alias valgrind='valgrind --extra-debuginfo-path=/app/.valgrind/libc6-dbg/usr/lib/debug'
