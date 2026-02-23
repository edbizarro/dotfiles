# Distro detection
if [ -f /etc/os-release ]; then
  . /etc/os-release
  export DISTRO_ID="$ID"
else
  export DISTRO_ID="unknown"
fi
