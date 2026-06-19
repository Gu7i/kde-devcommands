# Dev Commands — KDE Plasma Widget

A KDE Plasma 6 panel widget with a command reference cheat-sheet organized by tabs. Click any row to copy the command or shortcut to the clipboard.

![KDE Plasma 6](https://img.shields.io/badge/KDE_Plasma-6-blue?logo=kde)
![QML](https://img.shields.io/badge/QML-Qt_6-green?logo=qt)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

## Design

Same industrial HUD aesthetic as [Code Projects](https://github.com/Gu7i/kde-code-projects): gray background (`#c0c0c0`), thick black borders, monospace font, and neon green (`#00ff00`) as accent. Commands are displayed as two-line rows — the shortcut/command on top in bold monospace, the description below.

## Features

- **10 built-in tabs** — VSCODE · VIM · NVIM · LINUX · DOCKER · GIT · GIT FLOW · SSH · FFMPEG · REGEX
- **Click any row** to copy the command/shortcut to the clipboard instantly
- **Green toast** `✓ COPIADO` confirms the copy for 1.6s
- **Search** — filter commands within the active tab with `⌕ SRC`
- **Fully configurable** — add, rename or delete tabs and individual commands from the widget settings
- **Persists across reboots** — all data is stored in Plasma configuration as JSON

## Preview

```
╔══════════════════════════════════════════════════╗
║  ▌▌▌ DEV COMMANDS     TABS   CMDS               ║
║  PLASMA WIDGET // COMMAND REFERENCE   10   19   ║
╠══════════════════════════════════════════════════╣
║  [VSCODE] [VIM] [NVIM] [LINUX] [DOCKER] ...  ⌕ ║
╠══════════════════════════════════════════════════╣
║  SHORTCUT / COMANDO · DESCRIPCIÓN · CLICK COPIAR║
╠══════════════════════════════════════════════════╣
║  Ctrl+P                                         ║
║  Abrir archivo rápido                           ║
║─────────────────────────────────────────────────║
║  Ctrl+Shift+P                                   ║
║  Paleta de comandos                             ║
║─────────────────────────────────────────────────║
║  Ctrl+`                                         ║
║  Toggle terminal integrado                      ║
╠══════════════════════════════════════════════════╣
║  KDE::PLASMA DEV COMMANDS  //  v1.0             ║
╚══════════════════════════════════════════════════╝
```

## Installation

```bash
git clone https://github.com/Gu7i/kde-devcommands.git
cd kde-devcommands
chmod +x install.sh
./install.sh
```

Then right-click your panel → **Add Widgets** → search **Dev Commands**.

### Manual

```bash
INSTALL_DIR="$HOME/.local/share/plasma/plasmoids/com.guti.devcommands"
mkdir -p "$INSTALL_DIR"
cp -r contents metadata.json "$INSTALL_DIR/"
systemctl --user restart plasma-plasmashell
```

## Configuration

Right-click the widget → **Configure** to:

- Add / rename / delete tabs
- Add / edit / delete commands within any tab
- Reset everything to the built-in defaults

## Requirements

- KDE Plasma 6
- Qt 6 / QML

## License

MIT
