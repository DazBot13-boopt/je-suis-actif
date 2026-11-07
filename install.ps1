# Installe une tache planifiee Windows qui ecrit "je suis actif" toutes les 5 minutes.
# Usage (PowerShell) : irm https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/install.ps1 | iex
$ErrorActionPreference = 'Stop'

$Dir      = Join-Path $env:USERPROFILE 'actif'
$Script   = Join-Path $Dir 'je_suis_actif.ps1'
$Log      = Join-Path $Dir 'actif.log'
$TaskName = 'JeSuisActif'

# 1. Creer le script
New-Item -ItemType Directory -Force -Path $Dir | Out-Null
@"
Add-Content -Path '$Log' -Value "`$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - je suis actif"
"@ | Set-Content -Path $Script -Encoding UTF8

# 2. Creer la tache planifiee (toutes les 5 minutes, sans fin)
#    conhost --headless evite qu'une fenetre s'ouvre a chaque execution.
$Action = New-ScheduledTaskAction -Execute 'conhost.exe' `
  -Argument "--headless powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$Script`""
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
  -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 1)
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive

# -Force remplace la tache si elle existe deja (pas de doublon)
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger `
  -Settings $Settings -Principal $Principal -Force | Out-Null

# 3. Premier message tout de suite, pour verifier
Start-ScheduledTask -TaskName $TaskName

Write-Host "==> Installe !"
Write-Host "    Script : $Script"
Write-Host "    Log    : $Log"
Write-Host "    Voir les messages : Get-Content -Wait '$Log'"
