#!/usr/bin/env bash
# ==============================================================================
# Uninstaller for Nepali Keyboard Suite for Linux
# Developed by Grisma Bhandari (TopNepali)
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Uninstalling Nepali Keyboard Suite...${NC}"

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo -e "${RED}Error: This script requires root privileges or sudo.${NC}"
        exit 1
    fi
fi

# Remove m17n files
$SUDO rm -f /usr/share/m17n/ne-traditional.mim /usr/share/m17n/ne-romanized.mim
rm -f "${HOME}/.m17n.d/ne-traditional.mim" "${HOME}/.m17n.d/ne-romanized.mim" 2>/dev/null || true

# Restore XKB backup if present
if [ -f "/usr/share/X11/xkb/symbols/np.orig.bak" ]; then
    $SUDO mv -f "/usr/share/X11/xkb/symbols/np.orig.bak" "/usr/share/X11/xkb/symbols/np"
fi

# Remove binaries and desktop entries
$SUDO rm -f /usr/local/bin/nepali-switch /usr/local/bin/nepali-config
$SUDO rm -f /usr/share/applications/nepali-config.desktop
rm -f "${HOME}/.config/autostart/nepali-keyboard.desktop" "${HOME}/.config/autostart/ibus-daemon.desktop" 2>/dev/null || true
rm -rf "${HOME}/.config/nepali-keyboard" 2>/dev/null || true

# Reset XKB to US
setxkbmap -layout us 2>/dev/null || true

# Reset IBus engines
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng']" 2>/dev/null || true
fi

echo -e "${GREEN}✔ Nepali Keyboard Suite uninstalled cleanly.${NC}"
