#!/usr/bin/env sh

mons -o

case ${MONS_NUMBER} in
    1)
        wal -i ${HOME}/Pictures/Wallpapers -q -a 100
        ;;
    2)
        wal -i ${HOME}/Pictures/Wallpapers -q -a 100
        ;;
    *)
        # Handle it manually
        ;;
esac