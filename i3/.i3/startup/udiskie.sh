#!/usr/bin/env sh

# Terminate already running bar instances
killall -q udiskie

# Wait until the processes have been shut down
while pgrep -x udiskie > /dev/null; do sleep 1; done

# Launch udiskie
nohup udiskie > /dev/null 2>&1 &
