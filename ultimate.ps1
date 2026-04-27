if (-not ([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/thepinak503/vscode-config/main/ultimate.ps1 | iex`"" -Verb RunAs; exit }
$ErrorActionPreference="SilentlyContinue"
$g=powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
$s=($g|Select-String "([a-f0-9\-]{36})").Matches.Value
if(-not $s){$s=(powercfg -list|Select-String "Ultimate Performance").ToString().Split()[3]}
if($s){powercfg -setactive $s;"Ultimate Performance ACTIVATED: $s"}else{"FAILED"}
