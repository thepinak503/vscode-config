# VSCode Config

Personalized **VS Code settings** for a clean, productive setup with 100+ extensions.

---

## Quick Install

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.ps1 | iex
```

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh | sh
```

---

## Features

- Backs up existing `settings.json` automatically
- Installs 100+ VS Code extensions
- Detects VS Code & VS Code Insiders
- Supports System & User installations
- Cross-Platform: Windows, Linux, macOS

---

## Manual Download

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh -o code.sh
chmod +x code.sh
./code.sh
```

### Windows

```powershell
irm https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.ps1 -o code.ps1
.\code.ps1
```

---

## Supported Installations

| Platform | Editions |
|----------|----------|
| Windows | VS Code (System/User), Insiders (System/User) |
| Linux | VS Code (System/User/Snap), Insiders (System/User/Snap) |
| macOS | VS Code (System/User), Insiders (System/User) |

---

## Full Instructions

See [instructions.md](instructions.md) for detailed platform-specific guide.

---

## License

MIT License © [thepinak503](https://github.com/thepinak503)
