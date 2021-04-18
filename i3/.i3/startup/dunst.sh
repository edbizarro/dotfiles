#!/usr/bin/env sh

. "$HOME/.cache/wal/colors.sh"

# Terminate already running bar instances
killall -q dunst

# Wait until the processes have been shut down
while pgrep -x dunst >/dev/null; do sleep 1; done

dunst \
  -lb  "${background:-#FFFFFF}" \
  -nb  "${background:-#FFFFFF}" \
  -cb  "${background:-#FFFFFF}" \
  -lf  "${foreground:-#000000}" \
  -nf  "${foreground:-#000000}" \
  -cf  "${foreground:-#000000}" \
  -cfr "${color1:-#000000}" \
  -nf  "${foreground:-#000000}" \
  -lto 2 \
  -nto 2 \
  -cto 5 \
  -geometry "300x5-10+34" \
  -config ${HOME}/.config/dunst/dunstrc &
