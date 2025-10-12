@echo off
copy %userprofile%\AppData\Roaming\Code\User\settings.json %userprofile%\AppData\Roaming\Code\User\settings.json.bak
del %userprofile%\AppData\Roaming\Code\User\settings.json
curl -fsSL https://raw.githubusercontent.com/thepinak503/vscode-config/refs/heads/main/settings.json -o '%userprofile%\AppData\Roaming\Code\User\settings.json'

echo DONE!!
