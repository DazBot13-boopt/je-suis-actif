#!/usr/bin/env bash
# Supprime la tâche cron et le dossier ~/actif.
# Usage : curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/uninstall.sh | bash
set -euo pipefail

SCRIPT="$HOME/actif/je_suis_actif.sh"

if command -v crontab >/dev/null 2>&1; then
  ( crontab -l 2>/dev/null | grep -vF "$SCRIPT" || true ) | crontab -
fi
rm -rf "$HOME/actif"
echo "==> Désinstallé."
