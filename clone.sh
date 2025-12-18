#!/bin/sh

echo "Cloning repositories..."

SITES="$HOME/Sites"

mkdir -p "$SITES"

clone() {
  REPO="$1"
  DEST="$2"

  if [ -d "$DEST/.git" ]; then
    echo "✓ Skipping $(basename "$DEST") (already exists)"
  else
    echo "→ Cloning $(basename "$DEST")"
    git clone "$REPO" "$DEST"
  fi
}

# Personal
# clone git@github.com:webrobert/graham.git "$SITES/graham"
clone git@github.com:webrobert/pantry.git "$SITES/pantry"
