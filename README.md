# je-suis-actif

Une tâche cron qui écrit `je suis actif` toutes les 5 minutes dans un fichier de log.

## Installation (une seule commande)

Sur Linux ou macOS :

```bash
curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/install.sh | bash
```

Le script :

1. installe `cron` s'il n'est pas présent (apt, dnf, yum, apk ou pacman) ;
2. démarre le service cron ;
3. crée `~/actif/je_suis_actif.sh` ;
4. ajoute la tâche cron `*/5 * * * *` (sans doublon si tu le relances) ;
5. écrit un premier message tout de suite.

## Vérifier

```bash
tail -f ~/actif/actif.log
```

Une nouvelle ligne apparaît toutes les 5 minutes (à :00, :05, :10…).

## Désinstaller

```bash
curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/uninstall.sh | bash
```
