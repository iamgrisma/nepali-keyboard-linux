#!/usr/bin/env bash
# ==============================================================================
# Nepali Unicode & Romanized Keyboard Suite for Linux
# Developed by Grisma Bhandari (TopNepali)
# https://fonts.topnepali.com/guides | https://github.com/iamgrisma/nepali-keyboard-linux
# Supported: Ubuntu, Lubuntu, Debian, Fedora, Arch Linux, Linux Mint, openSUSE
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo -e "${CYAN}${BOLD}"
echo "=========================================================="
echo "   🇳🇵 Nepali Keyboard Suite for Linux (Initial v1.0.0)"
echo "   Developed by Grisma Bhandari (TopNepali)"
echo "   Universal Driver: Traditional & Romanized"
echo "   https://fonts.topnepali.com/guides"
echo "=========================================================="
echo -e "${NC}"

# Detect root / sudo
SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo -e "${RED}Error: This installer requires root privileges or sudo.${NC}"
        exit 1
    fi
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse mode argument if provided (--mode=both|traditional|romanized)
CHOSEN_MODE=""
for arg in "$@"; do
    case "$arg" in
        --mode=both|both)
            CHOSEN_MODE="both"
            ;;
        --mode=traditional|--mode=trad|traditional|trad)
            CHOSEN_MODE="traditional"
            ;;
        --mode=romanized|--mode=rom|romanized|rom)
            CHOSEN_MODE="romanized"
            ;;
    esac
done

# Step 1: Detect package manager and install dependencies
echo -e "${BLUE}▶ [1/6] Installing prerequisites (IBus, m17n & XKB)...${NC}"
if command -v apt-get >/dev/null 2>&1; then
    $SUDO apt-get update -qq || true
    $SUDO apt-get install -y ibus ibus-m17n m17n-db x11-xkb-utils libnotify-bin
elif command -v dnf >/dev/null 2>&1; then
    $SUDO dnf install -y ibus ibus-m17n m17n-db libnotify
elif command -v pacman >/dev/null 2>&1; then
    $SUDO pacman -Sy --noconfirm ibus ibus-m17n m17n-db libnotify
elif command -v zypper >/dev/null 2>&1; then
    $SUDO zypper install -y ibus ibus-m17n m17n-db libnotify
else
    echo -e "${YELLOW}Warning: Unknown package manager. Please ensure ibus and ibus-m17n are installed.${NC}"
fi

# Step 2: Install m17n input method definitions
echo -e "${BLUE}▶ [2/6] Installing Nepali input method definitions (m17n)...${NC}"
$SUDO mkdir -p /usr/share/m17n
$SUDO cp -f "${SCRIPT_DIR}/m17n/ne-traditional.mim" /usr/share/m17n/
$SUDO cp -f "${SCRIPT_DIR}/m17n/ne-romanized.mim" /usr/share/m17n/
$SUDO chmod 644 /usr/share/m17n/ne-traditional.mim /usr/share/m17n/ne-romanized.mim

# User fallback folder
mkdir -p "${HOME}/.m17n.d"
cp -f "${SCRIPT_DIR}/m17n/ne-traditional.mim" "${HOME}/.m17n.d/"
cp -f "${SCRIPT_DIR}/m17n/ne-romanized.mim" "${HOME}/.m17n.d/"

# Step 3: Install native XKB symbols (for zero-latency X11/Wayland switching)
echo -e "${BLUE}▶ [3/6] Installing native XKB keyboard layout definitions...${NC}"
if [ -d "/usr/share/X11/xkb/symbols" ]; then
    if [ -f "/usr/share/X11/xkb/symbols/np" ] && [ ! -f "/usr/share/X11/xkb/symbols/np.orig.bak" ]; then
        $SUDO cp "/usr/share/X11/xkb/symbols/np" "/usr/share/X11/xkb/symbols/np.orig.bak"
    fi
    $SUDO cp -f "${SCRIPT_DIR}/xkb/symbols/np" "/usr/share/X11/xkb/symbols/np"
    $SUDO chmod 644 "/usr/share/X11/xkb/symbols/np"
    # Clear xkb cache
    $SUDO rm -rf /var/lib/xkb/* 2>/dev/null || true
fi

# Step 4: Configure panel indicators in evdev.xml (displays 'EN', 'ने', and 'NE' on taskbar)
echo -e "${BLUE}▶ [4/6] Configuring taskbar indicator labels (EN, ने, NE)...${NC}"
if [ -f "/usr/share/X11/xkb/rules/evdev.xml" ]; then
    $SUDO python3 -c '
with open("/usr/share/X11/xkb/rules/evdev.xml", "r", encoding="utf-8") as f:
    content = f.read()

# Replace us with EN
old_us = """    <layout>
      <configItem>
        <name>us</name>
        <!-- Keyboard indicator for English layouts -->
        <shortDescription>en</shortDescription>
        <description>English (US)</description>"""

new_us = """    <layout>
      <configItem>
        <name>EN</name>
        <!-- Keyboard indicator for English layouts -->
        <shortDescription>en</shortDescription>
        <description>English (US)</description>"""

if old_us in content:
    content = content.replace(old_us, new_us, 1)

# Add custom indicator layouts if not already present
if "Nepali (Traditional, Loksewa/Remington)" not in content:
    insert_block = """  <layoutList>
    <layout>
      <configItem>
        <name>ने</name>
        <shortDescription>ने</shortDescription>
        <description>Nepali (Traditional, Loksewa/Remington)</description>
      </configItem>
    </layout>
    <layout>
      <configItem>
        <name>NE</name>
        <shortDescription>NE</shortDescription>
        <description>Nepali (Romanized, MPP Phonetic)</description>
      </configItem>
    </layout>"""
    if "  <layoutList>" in content:
        content = content.replace("  <layoutList>", insert_block, 1)

with open("/usr/share/X11/xkb/rules/evdev.xml", "w", encoding="utf-8") as f:
    f.write(content)
' 2>/dev/null || true
fi

# Step 5: Install CLI utilities and Desktop entry
echo -e "${BLUE}▶ [5/6] Installing nepali-switch and nepali-config utilities...${NC}"
$SUDO cp -f "${SCRIPT_DIR}/bin/nepali-switch" /usr/local/bin/nepali-switch
$SUDO cp -f "${SCRIPT_DIR}/bin/nepali-config" /usr/local/bin/nepali-config
$SUDO chmod 755 /usr/local/bin/nepali-switch /usr/local/bin/nepali-config

if [ -f "${SCRIPT_DIR}/desktop/nepali-config.desktop" ]; then
    $SUDO mkdir -p /usr/share/applications
    $SUDO cp -f "${SCRIPT_DIR}/desktop/nepali-config.desktop" /usr/share/applications/
    $SUDO chmod 644 /usr/share/applications/nepali-config.desktop
fi

# Configure desktop autostart for IBus daemon (with panel disabled to prevent stuck GTK popup windows)
mkdir -p "${HOME}/.config/autostart"
cat > "${HOME}/.config/autostart/ibus-daemon.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=IBus Daemon (Nepali)
Exec=ibus-daemon -drx --panel=disable
Hidden=false
NoDisplay=true
X-GNOME-Autostart-enabled=true
EOF

# Ensure clean IBus settings without systray clutter
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.freedesktop.ibus.general use-system-keyboard-layout true 2>/dev/null || true
    gsettings set org.freedesktop.ibus.panel show-icon-on-systray false 2>/dev/null || true
    gsettings set org.freedesktop.ibus.panel show 0 2>/dev/null || true
fi
killall ibus-ui-gtk3 2>/dev/null || true

# Step 6: Choose and apply layout configuration
echo -e "${BLUE}▶ [6/6] Configuring layout mode and shortcuts...${NC}"

# If mode was not passed via CLI and running interactively in terminal
if [ -z "$CHOSEN_MODE" ] && [ -t 0 ]; then
    echo ""
    echo -e "${CYAN}Please select your preferred Nepali typing layout mode:${NC}"
    echo "  [1] Both Traditional & Romanized (Default)"
    echo "      → Left Alt + Shift cycles: EN → ने → NE"
    echo "  [2] Traditional only (Remington Standard)"
    echo "      → Left Alt + Shift toggles: EN ↔ ने (No Romanized interference)"
    echo "  [3] Romanized only (MPP Phonetic)"
    echo "      → Left Alt + Shift toggles: EN ↔ NE (No Traditional interference)"
    echo ""
    read -r -p "Enter choice [1-3] (Default: 1): " user_choice
    case "$user_choice" in
        2) CHOSEN_MODE="traditional" ;;
        3) CHOSEN_MODE="romanized" ;;
        *) CHOSEN_MODE="both" ;;
    esac
fi

# Default to "both" if still empty
if [ -z "$CHOSEN_MODE" ]; then
    CHOSEN_MODE="both"
fi

# Run nepali-config with chosen mode
"${SCRIPT_DIR}/bin/nepali-config" "--mode=${CHOSEN_MODE}"

echo -e "\n${GREEN}${BOLD}✔ Installation completed successfully!${NC}\n"
echo -e "You can reconfigure your layout anytime by:"
echo -e "  • Running ${CYAN}nepali-config${NC} in terminal"
echo -e "  • Or opening ${BOLD}Nepali Keyboard Settings${NC} in your Application menu"
echo -e "  • Toggling layouts instantly with ${BOLD}Left Alt + Shift${NC} or ${BOLD}Win + Space${NC}"
echo -e "\nGuide & Keyboard Maps: ${CYAN}https://fonts.topnepali.com/guides${NC}\n"
