#!/usr/bin/env sh

# Terminate already running bar instances
killall -q mons

# Wait until the processes have been shut down
while pgrep -x mons >/dev/null; do sleep 1; done

# Launch mons
nohup mons -a -x "${HOME}/.i3/startup/mons_handler.sh" > /dev/null 2>&1 &
