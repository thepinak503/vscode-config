#!/bin/bash

if [ "$(uname)" = "Linux" ]; then
    echo ""
    echo "  ========================================================="
    echo "     🚫 WAIT A MINUTE! WRONG NEIGHBORHOOD! 🚫"
    echo "  ========================================================="
    echo ""
    echo "  Hey there, intrepid Linux User! 🐧"
    echo ""
    echo "  You look silly trying to run a macOS script on a Linux machine."
    echo "  That is like trying to charge an iPhone with a garden hose."
    echo ""
    echo "  This script looks for 'Application Support', which you don't have."
    echo "  Please switch to your Mac 🍎 to run this file!"
    echo ""
    echo "  (Don't worry, we won't tell anyone you tried this.)"
    echo "  ========================================================="
    echo ""
    read -p "Press [Enter] to hide your shame and exit..."
    exit 1
fi

VSCODE_DIR="$HOME/Library/Application Support/Code/User"
SETTINGS="$VSCODE_DIR/settings.json"
BACKUP="$VSCODE_DIR/settings.json.bak"
URL="https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/settings.json"

echo "[SCAN] Checking for VS Code on macOS..."

if [ ! -d "$VSCODE_DIR" ]; then
    echo "[WARN] VS Code directory not found at:"
    echo "$VSCODE_DIR"
    echo "Are you sure you have VS Code installed?"
    read -p "Press [Enter] to exit..."
    exit 1
fi

echo "[FOUND] VS Code settings folder."

if [ -f "$SETTINGS" ]; then
    echo "Backing up existing settings.json..."
    cp "$SETTINGS" "$BACKUP"
    echo "[INFO] Backup created."
fi

echo "Downloading new configuration..."
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$URL" -o "$SETTINGS"
    EXIT_CODE=$?
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$SETTINGS" "$URL"
    EXIT_CODE=$?
else
    echo "[ERR] Neither curl nor wget found."
    EXIT_CODE=1
fi

if [ $EXIT_CODE -ne 0 ]; then
    echo "[ERR] Failed to download settings."
else
    echo "[OK] Updated successfully!"
fi

echo "[DONE]"
read -p "Press [Enter] to close..."
