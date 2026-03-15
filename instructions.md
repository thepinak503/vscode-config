# VS Code Config - Installation Instructions

This guide covers installation for Windows, Linux, and macOS.

---

## Windows

### Quick Install (PowerShell)

```powershell
irm https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.ps1 | iex
```

### Manual Install

1. Download the script:
   ```powershell
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.ps1" -OutFile "$env:TEMP\code.ps1"
   ```

2. Run it:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   & "$env:TEMP\code.ps1"
   ```

### Detection

The script automatically detects:
- **VS Code (System)** - `C:\Program Files\Microsoft VS Code`
- **VS Code (User)** - `%AppData%\Code`
- **VS Code Insiders (System)** - `C:\Program Files\Microsoft VS Code Insiders`
- **VS Code Insiders (User)** - `%AppData%\Code - Insiders`

If multiple installations found, you'll be prompted to choose.

### Menu Options

1. Install settings.json
2. Install Extensions
3. Install Both

---

## Linux

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh | sh
```

### Manual Install

```bash
# Download
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh -o code.sh

# Run
chmod +x code.sh
./code.sh
```

### Detection

The script automatically detects:
- **VS Code (System)** - `/usr/bin/code`
- **VS Code (User)** - `~/.local/bin/code`
- **VS Code (Snap)** - `~/snap/code/common`
- **VS Code Insiders (System)** - `/usr/bin/code-insiders`
- **VS Code Insiders (User)** - `~/.local/bin/code-insiders`
- **VS Code Insiders (Snap)** - `~/snap/code-insiders/common`

If multiple installations found, you'll be prompted to choose.

---

## macOS

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh | sh
```

### Manual Install

```bash
# Download
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh -o code.sh

# Run
chmod +x code.sh
./code.sh
```

### Detection

The script automatically detects:
- **VS Code (System)** - `/Applications/Visual Studio Code.app`
- **VS Code (User)** - `~/Applications/Visual Studio Code.app`
- **VS Code Insiders (System)** - `/Applications/Visual Studio Code - Insiders.app`
- **VS Code Insiders (User)** - `~/Applications/Visual Studio Code - Insiders.app`

---

## Features

- **Automatic backup** - Creates `settings.json.bak` before overwriting
- **Extension installer** - Installs 100+ recommended extensions
- **Cross-platform** - Works on Windows, Linux, and macOS
- **Multiple VS Code editions** - Supports both Stable and Insiders
- **System & User installs** - Detects both installation types

## Settings Location

- **Windows:** `%AppData%\Code\User\settings.json`
- **Linux:** `~/.config/Code/User/settings.json`
- **macOS:** `~/Library/Application Support/Code/User/settings.json`

## Uninstall

Simply delete the downloaded files and restore from `settings.json.bak` if needed.

---

## License

MIT - [thepinak503](https://github.com/thepinak503)
