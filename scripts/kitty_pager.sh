#!/usr/bin/env bash

# Kitty pager from https://github.com/kovidgoyal/kitty/issues/719#issuecomment-952039731

set -eu

if [ "$#" -eq 3 ]; then
    INPUT_LINE_NUMBER=${1:-0}
    CURSOR_LINE=${2:-1}
    CURSOR_COLUMN=${3:-1}
    AUTOCMD_TERMCLOSE_CMD="call cursor(max([0,${INPUT_LINE_NUMBER}-1])+${CURSOR_LINE}, ${CURSOR_COLUMN})"
else
    AUTOCMD_TERMCLOSE_CMD="normal G"
fi

exec nvim 63<&0 0</dev/null
