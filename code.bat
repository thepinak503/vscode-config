@echo off
setlocal

:: Simple VS Code Settings Updater
set "VSCODE_DIR=%AppData%\Code\User"
set "SETTINGS=%VSCODE_DIR%\settings.json"
set "BACKUP=%VSCODE_DIR%\settings.json.bak"
set "URL=https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/settings.json"

echo [SCAN] Checking for VS Code...
if not exist "%VSCODE_DIR%" (
    echo [WARN] VS Code not found.
    pause
    exit /b
)

echo [FOUND] VS Code settings folder.

if exist "%SETTINGS%" (
    echo Backing up existing settings.json...
    copy /Y "%SETTINGS%" "%BACKUP%" >nul
)

echo Downloading new settings.json...
curl -fsSL "%URL%" -o "%SETTINGS%"

if %errorlevel% neq 0 (
    echo [ERR] Failed to download settings.
) else (
    echo [OK] Updated successfully!
)

echo [DONE]
pause
endlocal
