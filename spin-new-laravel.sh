#!/usr/bin/env bash
set -euo pipefail

# Usage: spin-new-laravel.sh app_name [laravel_version]
APP_NAME="${1:-}"
LARAVEL_VERSION="${2:-^11.0}"  # bump as you like

SITES="${SITES:-$HOME/Sites}"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found!"
  exit 1
fi

if ! command -v lando >/dev/null 2>&1; then
  echo "Lando not found!"
  exit 1
fi

if [[ -z "$APP_NAME" ]]; then
  echo "Usage: spin-new-laravel.sh <app_name> [laravel_version]"
  exit 1
fi

mkdir -p "$SITES"
cd "$SITES"

if [[ -e "$APP_NAME" ]]; then
  echo "Folder already exists: $SITES/$APP_NAME"
  exit 1
fi

echo "Creating Laravel project: $APP_NAME ($LARAVEL_VERSION) in $SITES"
docker run --rm -it \
  -v "$PWD:/app" \
  -u "$(id -u):$(id -g)" \
  composer:2 \
  create-project laravel/laravel "$APP_NAME" "$LARAVEL_VERSION"

cd "$APP_NAME"

echo "Initializing Lando..."
lando init --source cwd --webroot public --recipe laravel --name "$APP_NAME" --yes

# Write a fresh .lando.yml (don’t append blindly)
cat > .lando.yml <<EOM
name: ${APP_NAME}
recipe: laravel
config:
  php: '8.3'
  via: apache
  webroot: public
  database: mysql
  cache: redis

services:
  node:
    type: node:20
    scanner: false
  mail:
    type: mailhog
    portforward: true
    hogfrom:
      - appserver

tooling:
  npm:
    service: node
    cmd: npm
  migrate:
    service: appserver
    cmd: php artisan migrate

proxy:
  mail:
    - mail.${APP_NAME}.lndo.site
EOM

echo "Starting Lando..."
lando start

echo "Installing deps + generating key..."
lando composer install
lando artisan key:generate || true

echo "✅ Done: $SITES/$APP_NAME"
echo "Next: cd ~/Sites/$APP_NAME"
