# je-suis-actif

Une tâche planifiée qui écrit `je suis actif` toutes les 5 minutes dans un fichier de log.
Fonctionne sur Linux, macOS (cron) et Windows (Planificateur de tâches).

## Linux / macOS

### Installation (une seule commande)

```bash
curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/install.sh | bash
```

Le script :

1. installe `cron` s'il n'est pas présent (apt, dnf, yum, apk ou pacman) ;
2. démarre le service cron ;
3. crée `~/actif/je_suis_actif.sh` ;
4. ajoute la tâche cron `*/5 * * * *` (sans doublon si tu le relances) ;
5. écrit un premier message tout de suite.

### Vérifier

```bash
tail -f ~/actif/actif.log
```

Une nouvelle ligne apparaît toutes les 5 minutes (à :00, :05, :10…).

### Désinstaller

```bash
curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/uninstall.sh | bash
```

## Windows

Ouvre **PowerShell** (pas besoin d'être administrateur).

### Installation (une seule commande)

```powershell
irm https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/install.ps1 | iex
```

Le script :

1. crée `%USERPROFILE%\actif\je_suis_actif.ps1` ;
2. crée la tâche planifiée `JeSuisActif`, lancée toutes les 5 minutes, sans fenêtre qui s'ouvre (si tu la relances, elle est remplacée, pas dupliquée) ;
3. écrit un premier message tout de suite.

La tâche tourne quand ta session Windows est ouverte.

### Vérifier

```powershell
Get-Content -Wait $env:USERPROFILE\actif\actif.log
```

### Désinstaller

```powershell
irm https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/uninstall.ps1 | iex
```
