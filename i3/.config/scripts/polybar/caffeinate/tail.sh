#!/bin/bash

OUTPUTCAF=$(pgrep -x caffeinate)
OUTPUTCMD=""

if [ -z "$OUTPUTCAF" ]; then
    OUTPUTCMD="%{A1:~/.cargo/bin/caffeinate:}%{F#cccccc}%{F-}%{A}"
else
    OUTPUTCMD="%{A1:pkill -x caffeinate:}%{A}"
fi

echo "%{A3:~/.config/scripts/polybar/caffeinate/options.py:}$OUTPUTCMD%{A}"