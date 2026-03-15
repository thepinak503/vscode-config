$ErrorActionPreference = "Stop"

$URL_BASE = "https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main"

function Get-VSCodePath {
    $systemPath = "C:\Program Files\Microsoft VS Code"
    $systemInsiders = "C:\Program Files\Microsoft VS Code Insiders"
    $userPath = "$env:APPDATA\Code"
    $userInsiders = "$env:APPDATA\Code - Insiders"

    $editions = @()
    $paths = @{}

    if (Test-Path "$systemPath\bin\code.cmd") {
        $editions += "VS Code (System)"
        $paths["VS Code (System)"] = @{ InstallPath = $systemPath; CodeCmd = "code"; UserPath = "$env:APPDATA\Code" }
    }
    if (Test-Path "$systemInsiders\bin\code-insiders.cmd") {
        $editions += "VS Code Insiders (System)"
        $paths["VS Code Insiders (System)"] = @{ InstallPath = $systemInsiders; CodeCmd = "code-insiders"; UserPath = "$env:APPDATA\Code - Insiders" }
    }
    if (Test-Path "$userPath\bin\code.cmd") {
        $editions += "VS Code (User)"
        $paths["VS Code (User)"] = @{ InstallPath = $userPath; CodeCmd = "code"; UserPath = "$env:APPDATA\Code" }
    }
    if (Test-Path "$userInsiders\bin\code-insiders.cmd") {
        $editions += "VS Code Insiders (User)"
        $paths["VS Code Insiders (User)"] = @{ InstallPath = $userInsiders; CodeCmd = "code-insiders"; UserPath = "$env:APPDATA\Code - Insiders" }
    }

    if ($editions.Count -eq 0) {
        return $null
    }

    if ($editions.Count -eq 1) {
        $key = $editions[0]
        return @{
            Name = $key
            CodeCmd = $paths[$key].CodeCmd
            UserPath = "$($paths[$key].UserPath)\User"
        }
    }

    Write-Host "Multiple VS Code installations found:" -ForegroundColor Yellow
    Write-Host ""
    $i = 1
    foreach ($edition in $editions) {
        Write-Host "$i. $edition"
        $i++
    }
    Write-Host ""
    $choice = Read-Host "Select installation [1-$($editions.Count)]"

    $key = $editions[$choice - 1]
    return @{
        Name = $key
        CodeCmd = $paths[$key].CodeCmd
        UserPath = "$($paths[$key].UserPath)\User"
    }
}

function Install-Settings {
    param($VSCodeInfo)

    $vscodeDir = $VSCodeInfo.UserPath
    $settings = "$vscodeDir\settings.json"
    $backup = "$vscodeDir\settings.json.bak"
    $url = "$URL_BASE/settings.json"

    Write-Host "[SCAN] Checking for $($VSCodeInfo.Name)..." -ForegroundColor Cyan
    Write-Host "    User path: $vscodeDir" -ForegroundColor Gray

    if (-not (Test-Path $vscodeDir)) {
        Write-Host "[WARN] VS Code user directory not found." -ForegroundColor Yellow
        return $false
    }

    Write-Host "[FOUND] VS Code settings folder." -ForegroundColor Green

    if (Test-Path $settings) {
        Write-Host "Backing up existing settings.json..."
        Copy-Item $settings $backup -Force
    }

    try {
        Invoke-WebRequest -Uri $url -OutFile $settings -Force
        Write-Host "[OK] Settings updated successfully!" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "[ERR] Failed to download settings." -ForegroundColor Red
        return $false
    }
}

function Install-Extensions {
    param($VSCodeInfo)

    $codeCmd = $VSCodeInfo.CodeCmd

    Write-Host "[INFO] Downloading and running install-extensions.ps1..." -ForegroundColor Cyan
    Write-Host "    Using: $codeCmd" -ForegroundColor Gray

    $tempFile = "$env:TEMP\install-extensions.ps1"
    try {
        Invoke-WebRequest -Uri "$URL_BASE/install-extensions.ps1" -OutFile $tempFile -Force
        & $tempFile -CodeCommand $codeCmd
    } catch {
        Write-Host "[ERR] Failed to download extension installer." -ForegroundColor Red
    }
}

$isMac = $PSVersionTable.Platform -eq "Unix" -and (Test-Path "/Library")

if ($isMac -or $env:OS -eq "Darwin") {
    Write-Host ""
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host "     WRONG OS DETECTED!" -ForegroundColor Red
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  This script is for Windows only." -ForegroundColor Yellow
    Write-Host "  Please run 'code.sh' on Linux instead!"
    Write-Host "  =========================================================" -ForegroundColor Red
    Write-Host ""
    exit 1
}

$VSCodeInfo = Get-VSCodePath

if (-not $VSCodeInfo) {
    Write-Host "[ERR] VS Code not found." -ForegroundColor Red
    Write-Host "Please install VS Code from: https://code.visualstudio.com" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  VS Code Config Installer for Windows" -ForegroundColor Cyan
Write-Host "  Edition: $($VSCodeInfo.Name)" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Install settings.json" -ForegroundColor White
Write-Host "2. Install Extensions" -ForegroundColor White
Write-Host "3. Install Both" -ForegroundColor White
Write-Host "4. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Select option [1-4]"

switch ($choice) {
    "1" { Install-Settings -VSCodeInfo $VSCodeInfo }
    "2" { Install-Extensions -VSCodeInfo $VSCodeInfo }
    "3" {
        Install-Settings -VSCodeInfo $VSCodeInfo
        Install-Extensions -VSCodeInfo $VSCodeInfo
    }
    default { Write-Host "[INFO] Exiting." -ForegroundColor Gray }
}
