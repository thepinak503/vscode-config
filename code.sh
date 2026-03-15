#!/bin/sh

URL_BASE="https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main"

install_settings() {
    VSCODE_DIR="$HOME/.config/Code/User"
    SETTINGS="$VSCODE_DIR/settings.json"
    BACKUP="$VSCODE_DIR/settings.json.bak"
    URL="$URL_BASE/settings.json"

    echo "[SCAN] Checking for VS Code on Linux..."

    if [ ! -d "$VSCODE_DIR" ]; then
        echo "[WARN] VS Code not found."
        return 1
    fi

    echo "[FOUND] VS Code settings folder."

    if [ -f "$SETTINGS" ]; then
        echo "Backing up existing settings.json..."
        cp "$SETTINGS" "$BACKUP"
    fi

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$URL" -o "$SETTINGS"
    elif command -v wget >/dev/null 2>&1; then
        wget -qO "$SETTINGS" "$URL"
    else
        echo "[ERR] Neither curl nor wget found."
        return 1
    fi

    if [ $? -eq 0 ]; then
        echo "[OK] Settings updated successfully!"
    else
        echo "[ERR] Failed to download settings."
    fi
}

install_extensions() {
    echo "[INFO] Downloading and running install-extensions.sh..."
    curl -fsSL "$URL_BASE/install-extensions.sh" | sh
}

if [ "$(uname)" = "Darwin" ]; then
    echo ""
    echo "  ========================================================="
    echo "     WRONG OS DETECTED!"
    echo "  ========================================================="
    echo ""
    echo "  This script is for Linux only."
    echo "  Please use code.ps1 on Windows or code.sh on Linux."
    echo "  ========================================================="
    echo ""
    exit 1
fi

echo "=========================================="
echo "  VS Code Config Installer for Linux"
echo "=========================================="
echo ""
echo "1. Install settings.json"
echo "2. Install Extensions"
echo "3. Install Both"
echo "4. Exit"
echo ""

printf "Select option [1-4]: "
read choice

case $choice in
    1) install_settings ;;
    2) install_extensions ;;
    3)
        install_settings
        echo ""
        install_extensions
        ;;
    *) echo "[INFO] Exiting." ;;
esac
