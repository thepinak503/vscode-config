if (-not ([Security.Principal.WindowsPrincipal] 
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Re-launching with Administrator privileges..."
    Start-Process powershell `
        "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://your-link/ultimate-performance.ps1 | iex`"" `
        -Verb RunAs
    exit
}
$ErrorActionPreference = "SilentlyContinue"
$baseGuid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
Write-Host "Enabling Ultimate Performance mode..."
$output = powercfg -duplicatescheme $baseGuid
$schemeGuid = ($output | Select-String -Pattern "([a-f0-9\-]{36})").Matches.Value
if (-not $schemeGuid) {
    $schemeGuid = (powercfg -list | Select-String "Ultimate Performance").ToString().Split()[3]
}
if ($schemeGuid) {
    powercfg -setactive $schemeGuid
    Write-Host "Ultimate Performance ACTIVATED: $schemeGuid"
} else {
    Write-Host "Failed to activate Ultimate Performance mode."
}
