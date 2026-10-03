# 🇳🇵 Nepali Keyboard Suite for Linux (Universal Driver)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux%20(Universal)-blue.svg)](#supported-distributions)
[![Standard: MPP & Remington](https://img.shields.io/badge/Standard-MPP%20%26%20Remington-red.svg)](https://fonts.topnepali.com/guides)
[![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-green.svg)](https://github.com/iamgrisma/nepali-keyboard-linux/releases)

The official, production-ready **Nepali Unicode Keyboard Driver Suite for Linux**, developed by **Grisma Bhandari (TopNepali)**.

Brings 100% compliant **Nepali Unicode Traditional (Standard Remington)** and **Nepali Unicode Romanized (MPP Phonetic Standard)** to all modern Linux distributions. Includes instant **Left Alt + Shift** layout toggling, native X11 keysyms (for Terminals and File Managers), IBus smart ligature auto-normalization (for Browsers and Office), and unified taskbar badges (**EN**, **ने**, and **NE**).

Official documentation: [TopNepali Fonts Guides & Drivers](https://fonts.topnepali.com/guides)

---

## ⚡ Quick 1-Command Universal Installation

Open your terminal (Ctrl+Alt+T) and run:

```bash
curl -fsSL https://raw.githubusercontent.com/iamgrisma/nepali-keyboard-linux/main/install.sh | bash
```

During installation, you can choose your preferred layout mode:
1. **Both Layouts**: English (`EN`) → Traditional (`ने`) → Romanized (`NE`)
2. **Traditional Only**: English (`EN`) ↔ Traditional (`ने`) *(Classic typewriter layout)*
3. **Romanized Only**: English (`EN`) ↔ Romanized (`NE`) *(Everyday phonetic typing)*

---

## 📦 Distribution Packages (.deb & Tarball)

Pre-built binaries for the initial release are available directly from GitHub Releases:

- **Debian / Ubuntu / Lubuntu / Linux Mint**:
  Download [nepali-unicode-linux_1.0.0_all.deb](https://github.com/iamgrisma/nepali-keyboard-linux/releases/latest/download/nepali-unicode-linux_1.0.0_all.deb)
  ```bash
  sudo apt install ./nepali-unicode-linux_1.0.0_all.deb
  ```

- **Universal Tarball (Fedora, Arch Linux, openSUSE)**:
  Download [nepali-unicode-linux.tar.gz](https://github.com/iamgrisma/nepali-keyboard-linux/releases/latest/download/nepali-unicode-linux.tar.gz)
  ```bash
  tar -xzf nepali-unicode-linux.tar.gz
  cd nepali-unicode-linux && ./install.sh
  ```

---

## ✨ Features

- **🏛️ Standard Remington Typewriter Architecture**: Standard layout matching classic Nepali typewriter keystrokes.
- **✨ MPP Phonetic Romanized Standard**: Natural phonetic Devanagari typing (`k` ➔ `क`, `nepal` ➔ `नेपाल`, `q` ➔ `्`).
- **🎛️ Dedicated Configuration Manager (`nepali-config`)**:
  - Switch anytime between **Traditional Only**, **Romanized Only**, or **Both**.
  - Accessible via command line (`nepali-config`) or via Application Menu: **Nepali Keyboard Settings (नेपाली किबोर्ड सेटिङ)**.
- **🏷️ Unified Taskbar Status Indicators**:
  - `EN` : English (US)
  - `ने` : Nepali Traditional
  - `NE` : Nepali Romanized (Phonetic)
- **⌨️ Instant Windows-Style Toggle**:
  - **Left Alt + Shift** : Instant zero-latency layout rotation across every app.
  - **Win + Space** (Super+Space) : Fast layout toggle with desktop notification toast.
- **💻 Full Terminal & File Manager Support**:
  - Native X11 keysyms ensure direct typing in QTerminal, GNOME Terminal, PCManFM-Qt, Bash, Nano, Vim, and file rename dialogues.
- **🔗 Smart Ligature Auto-Normalization**:
  - `अ` + `ा` automatically normalizes to `आ`
  - `ा` + `े` automatically normalizes to `ो`
  - `ा` + `ै` automatically normalizes to `ौ`
  - `अ` + `ो` automatically normalizes to `ओ`
  - `अ` + `ौ` automatically normalizes to `औ`

---

## 🖥️ Supported Linux Distributions

| Distribution | Tested Desktop Environments | Status |
|---|---|:---:|
| **Ubuntu / Lubuntu / Xubuntu / Kubuntu** | LXQt, GNOME, KDE Plasma, XFCE | ✅ Verified |
| **Debian 11 / 12** | GNOME, XFCE, KDE Plasma | ✅ Verified |
| **Linux Mint / LMDE** | Cinnamon, MATE, XFCE | ✅ Verified |
| **Fedora 38+ / RHEL** | GNOME, KDE Plasma | ✅ Verified |
| **Arch Linux / Manjaro** | All DEs & Window Managers (Openbox, i3, Sway) | ✅ Verified |
| **openSUSE Tumbleweed / Leap** | GNOME, KDE Plasma | ✅ Verified |

---

## 🛠️ Included Utilities

### 1. `nepali-config` (Configuration Manager)
Run `nepali-config` in your terminal to change your layout mode or adjust hotkeys:
```bash
nepali-config                      # Interactive selector
nepali-config --mode=traditional   # Lock to English ↔ Traditional (Remington)
nepali-config --mode=romanized     # Lock to English ↔ Romanized (Phonetic)
nepali-config --mode=both          # Enable all three layouts
nepali-config --status             # View current configuration
```

### 2. `nepali-switch` (Direct Layout Switcher)
```bash
nepali-switch                      # Toggle to next layout
nepali-switch trad                 # Switch directly to Nepali Traditional
nepali-switch rom                  # Switch directly to Nepali Romanized
nepali-switch us                   # Switch directly to English (US)
```

---

## ⌨️ Keyboard Layout Reference

### Traditional Layout (Remington Standard)

| Key | Normal | Shift | Key | Normal | Shift |
|:---:|:---:|:---:|:---:|:---:|:---:|
| `` ` `` | **ञ** | **॥** | **a** | **ब** | **आ** |
| **1** | **१** | **ज्ञ** | **s** | **क** | **ङ्क** |
| **2** | **२** | **ई** | **d** | **म** | **ङ्ग** |
| **3** | **३** | **घ** | **f** | **ा** | **ँ** |
| **4** | **४** | **द्ध** | **g** | **न** | **द्द** |
| **5** | **५** | **छ** | **h** | **ज** | **झ** |
| **6** | **६** | **ट** | **j** | **व** | **ो** |
| **7** | **७** | **ठ** | **k** | **प** | **फ** |
| **8** | **८** | **ड** | **l** | **ि** | **ी** |
| **9** | **९** | **ढ** | **;** | **स** | **ट्ठ** |
| **0** | **०** | **ण** | **'** | **ु** | **ू** |
| **-** | **औ** | **ओ** | **z** | **श** | **क्क** |
| **=** | **‍** *(ZWJ)* | **‌** *(ZWNJ)* | **x** | **ह** | **ह्य** |
| **q** | **त्र** | **त्त** | **c** | **अ** | **ऋ** |
| **w** | **ध** | **ड्ढ** | **v** | **ख** | **ॐ** |
| **e** | **भ** | **ऐ** | **b** | **द** | **ौ** |
| **r** | **च** | **द्ब** | **n** | **ल** | **द्य** |
| **t** | **त** | **ट्ट** | **m** | **ः** | **ड्ड** |
| **y** | **थ** | **ठ्ठ** | **,** | **ऽ** | **ङ** |
| **u** | **ग** | **ऊ** | **.** | **।** | **श्र** |
| **i** | **ष** | **क्ष** | **/** | **र** | **रु** |
| **o** | **य** | **इ** | **\\** | **्** | **ं** |
| **p** | **उ** | **ए** | **[** | **र्** | **ृ** |
| **]** | **े** | **ै** | **Space** | *Space* | *Space* |

---

### Romanized Layout (MPP Phonetic)

- **Consonants**: `k` = क, `K` = ख, `g` = ग, `G` = घ, `c` = च, `C` = छ, `j` = ज, `J` = झ, `t` = त, `T` = थ, `d` = द, `D` = ध, `n` = न, `p` = प, `P` = फ, `b` = ब, `B` = भ, `m` = म, `y` = य, `r` = र, `l` = ल, `v`/`w` = व, `s` = स, `S` = श, `z` = ष, `h` = ह
- **Retroflex**: `q` = ट, `Q` = ठ, `x` = ड, `X` = ढ, `N` = ण
- **Vowels & Matras**: `a` = ा, `A` = आ, `i` = ि, `I` = ी, `u` = ु, `U` = ू, `e` = े, `E` = ै, `o` = ो, `O` = ओ, `w` = ौ, `W` = औ
- **Halanta & Symbols**: `/` = ् (halanta), `.` = ।, `$` = रु, `M` = ं (anusvara), `V` = ँ (candrabindu)

---

## 🗑️ Uninstallation

To remove the suite cleanly and restore system defaults:

```bash
curl -fsSL https://raw.githubusercontent.com/iamgrisma/nepali-keyboard-linux/main/uninstall.sh | bash
```

---

## 👨‍💻 Author & Attribution

- **Developer**: Grisma Bhandari ([@iamgrisma](https://github.com/iamgrisma))
- **Organization**: TopNepali ([fonts.topnepali.com](https://fonts.topnepali.com))
- **Layout Standards**: Madan Puraskar Pustakalaya (MPP) & Remington Standards
- **License**: [MIT License](LICENSE)
