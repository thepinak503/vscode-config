# VSCode Config

Personalized **VS Code settings** for a clean, productive setup.

---

## What This Does

- Backs up your existing `settings.json` automatically.
- Downloads and applies the preferred `settings.json`.
- Installs 100+ VS Code extensions.
- Cross-Platform: Works on **Windows** and **Linux**.
- Safe: Creates a `.bak` file before making changes.

---

## Quick Install

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.sh | sh
```

### Windows

Run this in **PowerShell**:

```powershell
irm https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/code.ps1 | iex
```

---

## Manual Usage

### Linux

```bash
# Make executable
chmod +x code.sh

# Run
./code.sh
```

### Windows

```powershell
# Run PowerShell script
.\code.ps1
```

Both scripts offer a menu:
1. Install settings.json
2. Install Extensions
3. Install Both

---

## Notes

- **Backup:** Your old settings are saved as `settings.json.bak`.
- **Target Locations:**
  - Windows: `%AppData%\Code\User`
  - Linux: `~/.config/Code/User`
- You can manually edit or restore the backup anytime.

---

## License

MIT License © [thepinak503](https://github.com/thepinak503)
