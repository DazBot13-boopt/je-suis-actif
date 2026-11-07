#!/usr/bin/env bash
# Installe une tâche cron qui écrit "je suis actif" toutes les 5 minutes.
# Usage : curl -fsSL https://raw.githubusercontent.com/DazBot13-boopt/je-suis-actif/main/install.sh | bash
set -euo pipefail

DIR="$HOME/actif"
SCRIPT="$DIR/je_suis_actif.sh"
LOG="$DIR/actif.log"
CRON_LINE="*/5 * * * * $SCRIPT"

# sudo seulement si on n'est pas root
SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

# 1. Installer cron s'il manque
if ! command -v crontab >/dev/null 2>&1; then
  echo "==> Installation de cron..."
  if command -v apt-get >/dev/null 2>&1; then
    $SUDO apt-get update -qq
    $SUDO DEBIAN_FRONTEND=noninteractive apt-get install -y -qq cron
  elif command -v dnf >/dev/null 2>&1; then
    $SUDO dnf install -y -q cronie
  elif command -v yum >/dev/null 2>&1; then
    $SUDO yum install -y -q cronie
  elif command -v apk >/dev/null 2>&1; then
    $SUDO apk add --quiet dcron
  elif command -v pacman >/dev/null 2>&1; then
    $SUDO pacman -S --noconfirm --needed cronie
  else
    echo "Erreur : impossible d'installer cron automatiquement sur ce système." >&2
    exit 1
  fi
fi

# 2. Démarrer le service cron (macOS : déjà actif)
if command -v systemctl >/dev/null 2>&1 && [ -d /run/systemd/system ]; then
  for svc in cron crond cronie; do
    if systemctl list-unit-files "$svc.service" 2>/dev/null | grep -q "^$svc.service"; then
      $SUDO systemctl enable --now "$svc" >/dev/null 2>&1 || true
      break
    fi
  done
elif command -v service >/dev/null 2>&1; then
  $SUDO service cron start >/dev/null 2>&1 || $SUDO service crond start >/dev/null 2>&1 || true
fi

# 3. Créer le script
mkdir -p "$DIR"
cat > "$SCRIPT" <<SCRIPT_EOF
#!/usr/bin/env bash
echo "\$(date '+%Y-%m-%d %H:%M:%S') - je suis actif" >> "$LOG"
SCRIPT_EOF
chmod +x "$SCRIPT"

# 4. Ajouter la tâche cron (sans doublon)
( crontab -l 2>/dev/null | grep -vF "$SCRIPT" || true; echo "$CRON_LINE" ) | crontab -

# 5. Premier message tout de suite, pour vérifier
"$SCRIPT"

echo "==> Installé !"
echo "    Script : $SCRIPT"
echo "    Log    : $LOG"
echo "    Voir les messages : tail -f $LOG"
