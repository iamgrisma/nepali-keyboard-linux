#!/usr/bin/env bash
# build-package.sh -- Build .deb and .tar.gz release packages
# Developed by Grisma Bhandari (TopNepali)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_DIR="${SCRIPT_DIR}/package"
BUILD_DIR="/tmp/deb-build-$$"

mkdir -p "$PACKAGE_DIR"
mkdir -p "${BUILD_DIR}/DEBIAN"
mkdir -p "${BUILD_DIR}/usr/share/m17n"
mkdir -p "${BUILD_DIR}/usr/share/X11/xkb/symbols"
mkdir -p "${BUILD_DIR}/usr/local/bin"
mkdir -p "${BUILD_DIR}/usr/share/applications"
mkdir -p "${BUILD_DIR}/usr/share/doc/nepali-unicode-linux"

echo "Building Debian package (nepali-unicode-linux_1.0.0_all.deb)..."

cat > "${BUILD_DIR}/DEBIAN/control" << 'EOF'
Package: nepali-unicode-linux
Version: 1.0.0
Section: utils
Priority: optional
Architecture: all
Depends: ibus, ibus-m17n, m17n-db, x11-xkb-utils
Maintainer: Grisma Bhandari <iamgrisma@gmail.com>
Homepage: https://github.com/iamgrisma/nepali-keyboard-linux
Description: Official Nepali Unicode & Romanized Keyboard Suite for Linux
 Production-grade Nepali Unicode typing drivers for Linux desktop environments.
 Developed by Grisma Bhandari (TopNepali).
 Includes:
  - Nepali Unicode Traditional (Standard Remington)
  - Nepali Unicode Romanized (MPP Phonetic Standard)
  - Layout Mode Selector (nepali-config) for Traditional, Romanized, or Both
  - Taskbar indicators: EN, [ने], and [NE]
  - Left Alt + Shift (and Win + Space) layout toggle
  - Dedicated CLI switcher (nepali-switch)
 Compatible with Ubuntu, Debian, Lubuntu, Linux Mint, Pop!_OS, Zorin OS.
EOF

cat > "${BUILD_DIR}/DEBIAN/postinst" << 'EOF'
#!/bin/sh
set -e

# Configure indicator labels in evdev.xml if present
if [ -f "/usr/share/X11/xkb/rules/evdev.xml" ]; then
    python3 -c '
with open("/usr/share/X11/xkb/rules/evdev.xml", "r", encoding="utf-8") as f:
    content = f.read()

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

# Clear XKB cache
rm -rf /var/lib/xkb/* 2>/dev/null || true

# Update desktop database
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database -q /usr/share/applications || true
# Kill any stuck ibus-ui-gtk3 popup processes
killall ibus-ui-gtk3 2>/dev/null || true

exit 0
EOF

chmod 755 "${BUILD_DIR}/DEBIAN/postinst"

# Copy files
cp "${SCRIPT_DIR}/m17n/ne-traditional.mim" "${BUILD_DIR}/usr/share/m17n/"
cp "${SCRIPT_DIR}/m17n/ne-romanized.mim" "${BUILD_DIR}/usr/share/m17n/"
cp "${SCRIPT_DIR}/xkb/symbols/np" "${BUILD_DIR}/usr/share/X11/xkb/symbols/"
cp "${SCRIPT_DIR}/bin/nepali-switch" "${BUILD_DIR}/usr/local/bin/"
cp "${SCRIPT_DIR}/bin/nepali-config" "${BUILD_DIR}/usr/local/bin/"
cp "${SCRIPT_DIR}/desktop/nepali-config.desktop" "${BUILD_DIR}/usr/share/applications/"
cp "${SCRIPT_DIR}/README.md" "${BUILD_DIR}/usr/share/doc/nepali-unicode-linux/"
cp "${SCRIPT_DIR}/LICENSE" "${BUILD_DIR}/usr/share/doc/nepali-unicode-linux/copyright"

chmod 755 "${BUILD_DIR}/usr/local/bin/nepali-switch" "${BUILD_DIR}/usr/local/bin/nepali-config"
chmod 644 "${BUILD_DIR}/usr/share/m17n/"*.mim
chmod 644 "${BUILD_DIR}/usr/share/X11/xkb/symbols/np"
chmod 644 "${BUILD_DIR}/usr/share/applications/nepali-config.desktop"

dpkg-deb --root-owner-group --build "$BUILD_DIR" "${PACKAGE_DIR}/nepali-unicode-linux_1.0.0_all.deb"
rm -rf "$BUILD_DIR"

echo "Building Universal Tarball (nepali-unicode-linux.tar.gz)..."
tar -czf "${PACKAGE_DIR}/nepali-unicode-linux.tar.gz" \
    -C "${SCRIPT_DIR}" \
    --exclude=".git" \
    --exclude="package" \
    --exclude="build-package.sh" \
    bin desktop m17n xkb install.sh uninstall.sh LICENSE README.md

echo "✓ Packages generated in ${PACKAGE_DIR}:"
ls -lh "${PACKAGE_DIR}"
