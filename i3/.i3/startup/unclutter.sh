#!/usr/bin/env sh

# Terminate already running bar instances
killall -q unclutter

# Wait until the processes have been shut down
while pgrep -x unclutter >/dev/null; do sleep 1; done

# Launch compton
unclutter &
