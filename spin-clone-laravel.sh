#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-}"
APP_NAME="${2:-}"

SITES="${SITES:-$HOME/Sites}"

if [[ -z "$REPO" || -z "$APP_NAME" ]]; then
  echo "Usage: spin-clone-laravel.sh <git_repo> <folder_name>"
  exit 1
fi

mkdir -p "$SITES"
cd "$SITES"

DEST="$SITES/$APP_NAME"
if [[ -d "$DEST/.git" ]]; then
  echo "Already exists: $DEST"
  exit 0
fi

git clone "$REPO" "$DEST"
cd "$DEST"

# If the repo already has .lando.yml, just start.
if [[ -f .lando.yml ]]; then
  lando start
  echo "✅ Done: $DEST"
  exit 0
fi

# Otherwise initialize Lando (assumes standard Laravel layout)
lando init --source cwd --webroot public --recipe laravel --name "$APP_NAME" --yes
lando start

echo "✅ Done: $DEST"
