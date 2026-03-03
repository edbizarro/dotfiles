# Distro detection
# Uses ID_LIKE as fallback for derivatives (e.g., endeavouros -> arch, pop -> ubuntu)
if [ -f /etc/os-release ]; then
  . /etc/os-release
  case "$ID" in
    arch|endeavouros|manjaro|garuda|artix)
      export DISTRO_ID="arch"
      ;;
    ubuntu|pop|linuxmint|elementary|zorin)
      export DISTRO_ID="ubuntu"
      ;;
    *)
      if echo "$ID_LIKE" | grep -q "arch"; then
        export DISTRO_ID="arch"
      elif echo "$ID_LIKE" | grep -q "ubuntu\|debian"; then
        export DISTRO_ID="ubuntu"
      else
        export DISTRO_ID="$ID"
      fi
      ;;
  esac
else
  export DISTRO_ID="unknown"
fi
