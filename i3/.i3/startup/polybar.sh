#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar bottom -r 2>&1 | tee -a /tmp/polybar.log & disown
polybar top -r 2>&1 | tee -a /tmp/polybar.log 2& disown