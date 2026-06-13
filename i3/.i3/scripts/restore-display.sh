#!/usr/bin/env sh
# restore-display.sh — re-enable the external monitor after a power-cycle blackout.
#
# Why this exists: `mons -a` only reconfigures when the connected-monitor count
# drops to exactly 1, so re-powering an external monitor never triggers it. And a
# monitor power-cycle often does NOT drop HDMI hot-plug detect, so xrandr still
# believes the output is at its current mode — a plain `--mode` becomes a no-op and
# never retrains the link. This script forces a fresh modeset (off -> on) to
# retrain the link, re-applying the "external-only" layout on demand (keybind).
#
# No hard-coded output names, resolutions, or refresh rates — all discovered at
# runtime so it survives setup changes:
#   internal panel = eDP* / LVDS* / DSI*    -> turned off
#   external(s)    = any other connected    -> first primary, rest extend right
# The primary external uses its native resolution (mode flagged '+' by xrandr) at
# the highest refresh rate offered for it (e.g. 3440x1440 @ 100). Falls back to the
# internal panel if no external can be brought up, so the screen is never left black.
#
# Logs every run to ~/.cache/restore-display.log so a still-black run is diagnosable.

LOG="${XDG_CACHE_HOME:-$HOME/.cache}/restore-display.log"
log() { printf '%s %s\n' "$(date '+%H:%M:%S')" "$*" >>"$LOG"; }

# run xrandr, log the command and its REAL exit code, and propagate that code so
# callers can detect failure (a plain `log` would otherwise mask xrandr's status).
run() {
    log "RUN xrandr $*"
    xrandr "$@" 2>>"$LOG"
    rc=$?
    log "    exit=$rc"
    return "$rc"
}

# best_mode <output> -> "WxH|RATE": native mode (line flagged '+') at its highest
# refresh; falls back to the largest-area mode if no line is flagged preferred.
best_mode() {
    xrandr --query | awk -v out="$1" '
        $1 == out { grab = 1; next }            # enter this output section (header skipped)
        /^[^ \t]/ { grab = 0 }                   # next output header ends the section
        grab && $1 ~ /^[0-9]+x[0-9]+$/ {         # a mode line
            rstr = ""; rnum = 0                  # best refresh on this line (keep string)
            for (i = 2; i <= NF; i++) {
                v = $i; gsub(/[*+]/, "", v)
                if (v + 0 > rnum) { rnum = v + 0; rstr = v }
            }
            split($1, d, "x"); area = d[1] * d[2]
            if (index($0, "+")) { pres = $1; prate = rstr; havep = 1 }
            if (area > barea) { barea = area; bres = $1; brate = rstr }
        }
        END {
            if (havep)        print pres "|" prate
            else if (bres != "") print bres "|" brate
        }'
}

# connected_with_modes <output> -> true if xrandr lists it connected AND offers modes.
connected_with_modes() {
    xrandr --query | awk -v o="$1" '
        $1 == o && / connected/ { hdr = 1; next }
        /^[^ \t]/ { hdr = 0 }
        hdr && /[0-9]+x[0-9]+/ { found = 1 }
        END { exit !found }'
}

# output_active <output> -> true if the output header carries a geometry (WxH+X+Y),
# i.e. it is actually driving a CRTC right now. The [+-] offsets cover outputs
# positioned at non-standard coordinates, not just the +0+0 primary.
output_active() {
    xrandr --query | awk -v o="$1" \
        '$1 == o && /[0-9]+x[0-9]+[+-][0-9]+[+-][0-9]+/ { f = 1 } END { exit !f }'
}

# enable_external <output> [extra xrandr flags...] -> 0 if it ends up active, else 1.
# Forces off -> re-probe -> wait-for-modes -> on, so the HDMI link actually retrains.
enable_external() {
    out=$1
    shift
    run --output "$out" --off
    i=0
    while [ "$i" -lt 3 ]; do                 # let i915 reflect the connector state
        xrandr --query >/dev/null 2>&1
        connected_with_modes "$out" && break
        i=$((i + 1))
        sleep 1                          # integer seconds — POSIX-portable
    done
    spec=$(best_mode "$out")
    mode=${spec%|*}
    rate=${spec#*|}
    if [ -n "$mode" ] && [ -n "$rate" ]; then
        run --output "$out" --mode "$mode" --rate "$rate" "$@"
    else
        run --output "$out" --auto "$@"
    fi
    if ! output_active "$out"; then          # recovery: one plain --auto retry
        log "  $out inactive after enable — retry --auto"
        run --output "$out" --auto "$@"
    fi
    output_active "$out"
}

log "===== invoked ====="
for f in /sys/class/drm/*/status; do
    log "sysfs $(basename "$(dirname "$f")") = $(cat "$f" 2>/dev/null)"
done
log "connected before: $(xrandr --query | awk '/ connected/{printf "%s ", $0}')"

internal=""
externals=""
# word-splitting on $externals is intentional (xrandr output names carry no spaces)
# shellcheck disable=SC2086
for out in $(xrandr --query | awk '/ connected/ {print $1}'); do
    case "$out" in
        eDP* | LVDS* | DSI*) internal="$out" ;;
        *) externals="$externals $out" ;;
    esac
done
log "internal='$internal' externals='$externals'"

primary=""
# word-splitting on $externals is intentional (output names carry no spaces)
# shellcheck disable=SC2086
for out in $externals; do
    if [ -z "$primary" ]; then
        if enable_external "$out" --primary; then
            primary="$out"
        fi
    else
        enable_external "$out" --right-of "$primary"
    fi
done

if [ -n "$primary" ]; then
    # An external is verified active -> internal panel off (the usual layout).
    [ -n "$internal" ] && run --output "$internal" --off
else
    # No external came up -> bring the internal panel on so we are never left black.
    log "no external active — falling back to internal panel"
    if [ -n "$internal" ]; then
        run --output "$internal" --primary --auto
        output_active "$internal" ||
            log "  WARNING: internal panel did not activate — screen may still be blank"
    fi
fi

log "connected after:  $(xrandr --query | awk '/ connected/{printf "%s ", $0}')"

# A fresh modeset leaves stale framebuffer content that windows repaint in blocks.
# Force a full-root redraw so the screen comes back clean instead of tile-by-tile.
if [ -n "$primary" ] && command -v xrefresh >/dev/null 2>&1; then
    log "RUN xrefresh"
    xrefresh 2>>"$LOG"
    log "    exit=$?"
fi

log "===== done ====="
