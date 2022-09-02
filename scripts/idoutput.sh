#!/bin/sh
# Identify output (For each line is it stdout or stderr?)
# From: https://unix.stackexchange.com/questions/569935/piping-data-to-a-script-or-function-determining-whether-the-output-is-coming-to

{ "$@" 2>&1 >&3 | sed 's/^/err: /' >&2; } 3>&1 | sed 's/^/out: /'

