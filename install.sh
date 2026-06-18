#!/usr/bin/env bash

set -e

PLUGIN_ID="com.guti.devcommands"
INSTALL_DIR="$HOME/.local/share/plasma/plasmoids/$PLUGIN_ID"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    echo "Usage: $0 [install|uninstall]"
    echo "  install    Install or update the widget (default)"
    echo "  uninstall  Remove the widget"
}

do_uninstall() {
    if [ -d "$INSTALL_DIR" ]; then
        echo "Removing $INSTALL_DIR..."
        rm -rf "$INSTALL_DIR"
        systemctl --user restart plasma-plasmashell
        echo "Uninstalled."
    else
        echo "Widget is not installed."
    fi
}

do_install() {
    if [ "$SCRIPT_DIR" = "$INSTALL_DIR" ]; then
        echo "Already running from install location, skipping copy."
    else
        if [ -d "$INSTALL_DIR" ]; then
            echo "Removing previous installation..."
            rm -rf "$INSTALL_DIR"
        fi
        echo "Copying files to $INSTALL_DIR..."
        mkdir -p "$INSTALL_DIR"
        cp -r "$SCRIPT_DIR/contents" "$INSTALL_DIR/"
        cp "$SCRIPT_DIR/metadata.json" "$INSTALL_DIR/"
    fi

    echo "Restarting Plasma shell..."
    systemctl --user restart plasma-plasmashell

    echo ""
    echo "Done! Add the widget to your panel:"
    echo "  Right-click panel → Add Widgets → search 'Dev Commands'"
}

case "${1:-install}" in
    install)   do_install ;;
    uninstall) do_uninstall ;;
    *)         usage; exit 1 ;;
esac
