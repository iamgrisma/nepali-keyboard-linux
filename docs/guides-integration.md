# Integration Guide for Top Nepali Fonts (`fonts.topnepali.com/guides`)

This document provides ready-to-use snippets to add official Linux support to **Top Nepali Fonts** (`https://fonts.topnepali.com/guides`), alongside the existing Windows and macOS packages.

---

## 1. Quick Install One-Liner (For Developers / Terminal Users)

Users can install and configure the entire suite on any Linux distro with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/iamgrisma/nepali-keyboard-linux/main/install.sh | bash
```

---

## 2. Astro / HTML Component Code for `fonts.topnepali.com`

Update the download button row under **Nepali Unicode Traditional** and **Nepali Unicode Romanized** cards:

```astro
<!-- 3-Button Download Row (Windows, macOS, Linux) -->
<div class="grid grid-cols-1 sm:grid-cols-3 gap-2 text-sm font-semibold">
  <!-- Windows -->
  <a href="/download/nepali-traditional-windows" class="py-2.5 px-3 rounded-xl border border-neutral-300 dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-800 text-neutral-800 dark:text-neutral-200 text-center transition flex items-center justify-center gap-1.5">
    <svg width="1em" height="1em" viewBox="0 0 24 24" class="w-4 h-4 text-blue-600"><rect width="20" height="14" x="2" y="3" rx="2"/><path d="M8 21h8m-4-4v4"/></svg>
    <span>Windows ZIP (675 KB)</span>
  </a>

  <!-- macOS -->
  <a href="/download/nepali-traditional-mac" class="py-2.5 px-3 rounded-xl border border-neutral-300 dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-800 text-neutral-800 dark:text-neutral-200 text-center transition flex items-center justify-center gap-1.5">
    <svg width="1em" height="1em" viewBox="0 0 24 24" class="w-4 h-4 text-neutral-700 dark:text-neutral-300"><path d="M18 5a2 2 0 0 1 2 2v8.526a2 2 0 0 0 .212.897l1.068 2.127a1 1 0 0 1-.9 1.45H3.62a1 1 0 0 1-.9-1.45l1.068-2.127A2 2 0 0 0 4 15.526V7a2 2 0 0 1 2-2zm2.054 10.987H3.946"/></svg>
    <span>macOS ZIP (3.4 KB)</span>
  </a>

  <!-- Linux Universal -->
  <a href="https://github.com/iamgrisma/nepali-keyboard-linux/releases/latest/download/nepali-unicode-linux.tar.gz" class="py-2.5 px-3 rounded-xl border border-neutral-300 dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-800 text-neutral-800 dark:text-neutral-200 text-center transition flex items-center justify-center gap-1.5" title="Universal Linux Installer (Ubuntu, Fedora, Arch, Lubuntu, Debian)">
    <svg width="1em" height="1em" viewBox="0 0 24 24" class="w-4 h-4 text-amber-600"><path d="M12 2a5 5 0 0 0-5 5v3H6a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8a2 2 0 0 0-2-2h-1V7a5 5 0 0 0-5-5z"/></svg>
    <span>Linux Universal (Tarball)</span>
  </a>
</div>
```

---

## 3. Dedicated Linux Tab / Section Text for Guides Page

```markdown
### 🐧 Linux Installation Guide (Ubuntu, Lubuntu, Debian, Fedora, Arch)

1. Open your terminal and run:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/iamgrisma/nepali-keyboard-linux/main/install.sh | bash
   ```
2. Press **Left Alt + Shift** or **Win + Space** anywhere to switch between English, Nepali Traditional, and Nepali Romanized.
3. A desktop notification will confirm the active layout.
```
