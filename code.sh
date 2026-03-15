#!/bin/sh

URL_BASE="https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main"

detect_vscode() {
    editions=""
    paths=""

    if [ -f "/usr/bin/code" ]; then
        editions="$editions /usr/bin/code"
        paths="$paths /usr/share/code:/usr/bin/code:$HOME/.config/Code"
    fi

    if [ -f "/usr/bin/code-insiders" ]; then
        editions="$editions /usr/bin/code-insiders"
        paths="$paths /usr/share/code-insiders:/usr/bin/code-insiders:$HOME/.config/Code - Insiders"
    fi

    if [ -f "$HOME/.local/bin/code" ]; then
        editions="$versions $HOME/.local/bin/code"
        paths="$paths:$HOME/.local/share/code:$HOME/.local/bin/code:$HOME/.config/Code"
    fi

    if [ -f "$HOME/.local/bin/code-insiders" ]; then
        editions="$versions $HOME/.local/bin/code-insiders"
        paths="$paths:$HOME/.local/share/code-insiders:$HOME/.local/bin/code-insiders:$HOME/.config/Code - Insiders"
    fi

    if [ -d "$HOME/snap/code/common" ]; then
        editions="$editions snap-code"
        paths="$paths:$HOME/snap/code/current:$HOME/snap/code/common:$HOME/.config/Code"
    fi

    if [ -d "$HOME/snap/code-insiders/common" ]; then
        editions="$editions snap-code-insiders"
        paths="$paths:$HOME/snap/code-insiders/current:$HOME/snap/code-insiders/common:$HOME/.config/Code - Insiders"
    fi

    if [ -d "$HOME/.config/Code" ] && [ -f "$HOME/.config/Code/bin/code" ]; then
        editions="$editions code-user"
        paths="$paths:$HOME/.config/Code:$HOME/.config/Code/bin/code:$HOME/.config/Code"
    fi

    if [ -d "$HOME/.config/Code - Insiders" ] && [ -f "$HOME/.config/Code - Insiders/bin/code-insiders" ]; then
        editions="$editions code-insiders-user"
        paths="$paths:$HOME/.config/Code - Insiders:$HOME/.config/Code - Insiders/bin/code-insiders:$HOME/.config/Code - Insiders"
    fi

    echo "$editions"
    echo "$paths"
}

get_edition_name() {
    case "$1" in
        /usr/bin/code) echo "VS Code (System)" ;;
        /usr/bin/code-insiders) echo "VS Code Insiders (System)" ;;
        $HOME/.local/bin/code) echo "VS Code (User)" ;;
        $HOME/.local/bin/code-insiders) echo "VS Code Insiders (User)" ;;
        snap-code) echo "VS Code (Snap)" ;;
        snap-code-insiders) echo "VS Code Insiders (Snap)" ;;
        code-user) echo "VS Code (User)" ;;
        code-insiders-user) echo "VS Code Insiders (User)" ;;
        *) echo "$1" ;;
    esac
}

install_settings() {
    CODE_PATH="$1"
    VSCODE_DIR="$2"
    SETTINGS="$VSCODE_DIR/settings.json"
    BACKUP="$VSCODE_DIR/settings.json.bak"
    URL="$URL_BASE/settings.json"

    echo "[SCAN] Checking for VS Code..."
    echo "    Code: $CODE_PATH"
    echo "    User path: $VSCODE_DIR"

    if [ ! -d "$VSCODE_DIR" ]; then
        echo "[WARN] VS Code user directory not found."
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
    CODE_PATH="$1"
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
    echo "  Please use code.ps1 on Windows instead!"
    echo "  ========================================================="
    echo ""
    exit 1
fi

echo "Detecting VS Code installations..."
echo ""

count=0
editions=""
paths=""

if [ -f "/usr/bin/code" ]; then
    count=$((count + 1))
    editions="$editions /usr/bin/code"
    paths="$paths /usr/share/code:/usr/bin/code:$HOME/.config/Code"
    echo "$count. VS Code (System)"
fi

if [ -f "/usr/bin/code-insiders" ]; then
    count=$((count + 1))
    editions="$editions /usr/bin/code-insiders"
    paths="$paths /usr/share/code-insiders:/usr/bin/code-insiders:$HOME/.config/Code - Insiders"
    echo "$count. VS Code Insiders (System)"
fi

if [ -f "$HOME/.local/bin/code" ]; then
    count=$((count + 1))
    editions="$editions $HOME/.local/bin/code"
    paths="$paths:$HOME/.local/share/code:$HOME/.local/bin/code:$HOME/.config/Code"
    echo "$count. VS Code (User)"
fi

if [ -f "$HOME/.local/bin/code-insiders" ]; then
    count=$((count + 1))
    editions="$editions $HOME/.local/bin/code-insiders"
    paths="$paths:$HOME/.local/share/code-insiders:$HOME/.local/bin/code-insiders:$HOME/.config/Code - Insiders"
    echo "$count. VS Code Insiders (User)"
fi

if [ -d "$HOME/snap/code/common" ]; then
    count=$((count + 1))
    editions="$editions snap-code"
    paths="$paths:$HOME/snap/code/current:$HOME/snap/code/common:$HOME/.config/Code"
    echo "$count. VS Code (Snap)"
fi

if [ -d "$HOME/snap/code-insiders/common" ]; then
    count=$((count + 1))
    editions="$editions snap-code-insiders"
    paths="$paths:$HOME/snap/code-insiders/current:$HOME/snap/code-insiders/common:$HOME/.config/Code - Insiders"
    echo "$count. VS Code Insiders (Snap)"
fi

if [ -d "$HOME/.config/Code" ] && [ -f "$HOME/.config/Code/bin/code" ]; then
    count=$((count + 1))
    editions="$editions code-user"
    paths="$paths:$HOME/.config/Code:$HOME/.config/Code/bin/code:$HOME/.config/Code"
    echo "$count. VS Code (User)"
fi

if [ -d "$HOME/.config/Code - Insiders" ] && [ -f "$HOME/.config/Code - Insiders/bin/code-insiders" ]; then
    count=$((count + 1))
    editions="$editions code-insiders-user"
    paths="$paths:$HOME/.config/Code - Insiders:$HOME/.config/Code - Insiders/bin/code-insiders:$HOME/.config/Code - Insiders"
    echo "$count. VS Code Insiders (User)"
fi

if [ $count -eq 0 ]; then
    echo "[ERR] No VS Code installation found."
    echo "Please install VS Code from: https://code.visualstudio.com"
    exit 1
fi

if [ $count -eq 1 ]; then
    SELECTED=1
else
    echo ""
    printf "Select installation [1-$count]: "
    read SELECTED
fi

case $SELECTED in
    1) CODE_PATH="/usr/bin/code"; VSCODE_DIR="$HOME/.config/Code" ;;
    2) CODE_PATH="/usr/bin/code-insiders"; VSCODE_DIR="$HOME/.config/Code - Insiders" ;;
    3) CODE_PATH="$HOME/.local/bin/code"; VSCODE_DIR="$HOME/.config/Code" ;;
    4) CODE_PATH="$HOME/.local/bin/code-insiders"; VSCODE_DIR="$HOME/.config/Code - Insiders" ;;
    5) CODE_PATH="snap"; VSCODE_DIR="$HOME/.config/Code" ;;
    6) CODE_PATH="snap-insiders"; VSCODE_DIR="$HOME/.config/Code - Insiders" ;;
    7) CODE_PATH="$HOME/.config/Code/bin/code"; VSCODE_DIR="$HOME/.config/Code" ;;
    8) CODE_PATH="$HOME/.config/Code - Insiders/bin/code-insiders"; VSCODE_DIR="$HOME/.config/Code - Insiders" ;;
    *) echo "[ERR] Invalid selection."; exit 1 ;;
esac

echo ""
echo "=========================================="
echo "  VS Code Config Installer for Linux"
echo "  Edition: $CODE_PATH"
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
    1) install_settings "$CODE_PATH" "$VSCODE_DIR" ;;
    2) install_extensions "$CODE_PATH" ;;
    3)
        install_settings "$CODE_PATH" "$VSCODE_DIR"
        echo ""
        install_extensions "$CODE_PATH"
        ;;
    *) echo "[INFO] Exiting." ;;
esac
