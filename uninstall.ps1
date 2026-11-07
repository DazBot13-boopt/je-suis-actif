# Supprime la tache planifiee et le dossier actif.
# Usage (PowerShell) : irm https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/uninstall.ps1 | iex
$TaskName = 'JeSuisActif'

Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path (Join-Path $env:USERPROFILE 'actif') -ErrorAction SilentlyContinue
Write-Host "==> Desinstalle."
