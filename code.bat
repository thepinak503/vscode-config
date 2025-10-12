@echo off
setlocal EnableDelayedExpansion

:: ------------------------------
:: Universal VS Code Settings Updater
:: Author: Pinak
:: ------------------------------

:: Base path for VS Code settings
set "BASE=%userprofile%\AppData\Roaming"

:: Possible VS Code directories
set "VERSIONS=Code Code - Insiders Code - OSS VSCodium"

:: Remote settings file URL
set "URL=https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/settings.json"

echo.
echo 🔍 Searching for installed VS Code variants...
echo.

set "found=false"

for %%V in (%VERSIONS%) do (
    set "VSCODE_DIR=%BASE%\%%V\User"
    set "SETTINGS=%VSCODE_DIR%\settings.json"
    set "BACKUP=%VSCODE_DIR%\settings.json.bak"

    if exist "!VSCODE_DIR!" (
        echo ✅ Found: %%V
        set "found=true"

        if exist "!SETTINGS!" (
            echo   Backing up existing settings.json...
            copy /Y "!SETTINGS!" "!BACKUP!" >nul
            del "!SETTINGS!"
        ) else (
            echo   No settings.json found, skipping backup.
        )

        echo   Downloading new settings.json...
        curl -fsSL "%URL%" -o "!SETTINGS!"

        if !errorlevel! neq 0 (
            echo   ❌ Error downloading for %%V.
        ) else (
            echo   ✅ Updated successfully for %%V.
        )

        echo.
    )
)

if "%found%"=="false" (
    echo ⚠️ No VS Code variants found under "%BASE%".
)

echo.
echo 🏁 All done!
pause
endlocal
