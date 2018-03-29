#!/usr/bin/env sh

# Terminate already running bar instances
killall -q mons

# Wait until the processes have been shut down
while pgrep -x mons >/dev/null; do sleep 1; done

# Launch mons
nohup mons -a > /dev/null 2>&1 &
