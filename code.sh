#!/bin/bash

VSCODE_DIR="$HOME/.config/Code/User"
SETTINGS="$VSCODE_DIR/settings.json"
BACKUP="$VSCODE_DIR/settings.json.bak"
URL="https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/settings.json"

echo "[SCAN] Checking for VS Code..."

if [ ! -d "$VSCODE_DIR" ]; then
    echo "[WARN] VS Code not found."
    read -p "Press [Enter] to exit..."
    exit 1
fi

echo "[FOUND] VS Code settings folder."

if [ -f "$SETTINGS" ]; then
    echo "Backing up existing settings.json..."
    cp "$SETTINGS" "$BACKUP"
fi

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
