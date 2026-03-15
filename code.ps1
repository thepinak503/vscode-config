$ErrorActionPreference = "Stop"

$URL_BASE = "https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main"

function Install-Settings {
    $VSCODE_DIR = "$env:APPDATA\Code\User"
    $SETTINGS = "$VSCODE_DIR\settings.json"
    $BACKUP = "$VSCODE_DIR\settings.json.bak"
    $URL = "$URL_BASE/settings.json"

    Write-Host "[SCAN] Checking for VS Code on Windows..." -ForegroundColor Cyan

    if (-not (Test-Path $VSCODE_DIR)) {
        Write-Host "[WARN] VS Code not found." -ForegroundColor Yellow
        return $false
    }

    Write-Host "[FOUND] VS Code settings folder." -ForegroundColor Green

    if (Test-Path $SETTINGS) {
        Write-Host "Backing up existing settings.json..."
        Copy-Item $SETTINGS $BACKUP -Force
    }

    try {
        Invoke-WebRequest -Uri $URL -OutFile $SETTINGS -Force
        Write-Host "[OK] Settings updated successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "[ERR] Failed to download settings." -ForegroundColor Red
        return $false
    }
}

function Install-Extensions {
    Write-Host "[INFO] Downloading and running install-extensions.ps1..." -ForegroundColor Cyan

    $tempFile = "$env:TEMP\install-extensions.ps1"
    try {
        Invoke-WebRequest -Uri "$URL_BASE/install-extensions.ps1" -OutFile $tempFile -Force
        & $tempFile
    } catch {
        Write-Host "[ERR] Failed to download extension installer." -ForegroundColor Red
    }
}

$isMac = $PSVersionTable.Platform -eq "Unix" -and (Test-Path "/Library")

if ($isMac -or $env:OS -eq "Darwin") {
    Write-Host ""
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host "     :x: HOLD YOUR HORSES! WRONG OS! :x:" -ForegroundColor Red
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Hello there, Mac User!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  You look a bit confused trying to run a PowerShell script on macOS."
    Write-Host "  This script is for Windows only."
    Write-Host ""
    Write-Host "  Please run 'code.sh' on your Linux machine instead!"
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  VS Code Config Installer for Windows" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Install settings.json" -ForegroundColor White
Write-Host "2. Install Extensions" -ForegroundColor White
Write-Host "3. Install Both" -ForegroundColor White
Write-Host "4. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Select option [1-4]"

switch ($choice) {
    "1" { Install-Settings }
    "2" { Install-Extensions }
    "3" {
        Install-Settings
        Install-Extensions
    }
    default { Write-Host "[INFO] Exiting." -ForegroundColor Gray }
}
