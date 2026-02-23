#!/bin/bash
#
# Auto-detect hardware values for polybar config.
# Run this once per machine to generate hardware.ini
#
# Usage: bash setup-hardware.sh
#

OUTPUT="${HOME}/.config/polybar/hardware.ini"

echo "[hardware]" > "$OUTPUT"

# Thermal zone - find x86_pkg_temp or first available
THERMAL_ZONE=0
for zone in /sys/class/thermal/thermal_zone*; do
  type=$(cat "$zone/type" 2>/dev/null)
  if [[ "$type" == "x86_pkg_temp" ]]; then
    THERMAL_ZONE=$(basename "$zone" | tr -dc '0-9')
    break
  fi
done
echo "thermal-zone = $THERMAL_ZONE" >> "$OUTPUT"

# hwmon path - find coretemp or first available temp input
HWMON_PATH=""
for hwmon in /sys/class/hwmon/hwmon*; do
  name=$(cat "$hwmon/name" 2>/dev/null)
  if [[ "$name" == "coretemp" ]]; then
    for temp in "$hwmon"/temp*_input; do
      HWMON_PATH="$temp"
      break
    done
    break
  fi
done
if [[ -z "$HWMON_PATH" ]]; then
  # Fallback: first available temp input
  for temp in /sys/class/hwmon/hwmon*/temp1_input; do
    HWMON_PATH="$temp"
    break
  done
fi
echo "hwmon-path = $HWMON_PATH" >> "$OUTPUT"

# Backlight card
BACKLIGHT_CARD="intel_backlight"
if [ -d /sys/class/backlight/intel_backlight ]; then
  BACKLIGHT_CARD="intel_backlight"
elif [ -d /sys/class/backlight/amdgpu_bl0 ]; then
  BACKLIGHT_CARD="amdgpu_bl0"
elif [ -d /sys/class/backlight/amdgpu_bl1 ]; then
  BACKLIGHT_CARD="amdgpu_bl1"
else
  # Use first available
  FIRST=$(ls /sys/class/backlight/ 2>/dev/null | head -1)
  [ -n "$FIRST" ] && BACKLIGHT_CARD="$FIRST"
fi
echo "backlight-card = $BACKLIGHT_CARD" >> "$OUTPUT"

# WiFi interface
WIFI_IF="wlan0"
for iface in /sys/class/net/wl*; do
  if [ -d "$iface" ]; then
    WIFI_IF=$(basename "$iface")
    break
  fi
done
echo "wifi-interface = $WIFI_IF" >> "$OUTPUT"

# Ethernet interface
ETH_IF="enp3s0"
for iface in /sys/class/net/en* /sys/class/net/eth*; do
  if [ -d "$iface" ]; then
    ETH_IF=$(basename "$iface")
    break
  fi
done
echo "eth-interface = $ETH_IF" >> "$OUTPUT"

# Battery
BATTERY="BAT0"
for bat in /sys/class/power_supply/BAT*; do
  if [ -d "$bat" ]; then
    BATTERY=$(basename "$bat")
    break
  fi
done
echo "battery = $BATTERY" >> "$OUTPUT"

# AC adapter
ADAPTER="AC"
for ac in /sys/class/power_supply/AC* /sys/class/power_supply/ACAD*; do
  if [ -d "$ac" ]; then
    ADAPTER=$(basename "$ac")
    break
  fi
done
echo "adapter = $ADAPTER" >> "$OUTPUT"

echo "Generated $OUTPUT:"
cat "$OUTPUT"
