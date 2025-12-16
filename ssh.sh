#!/usr/bin/env bash
set -e

EMAIL="${1:-}"

if [ -z "$EMAIL" ]; then
  echo "Usage: ssh.sh <email>"
  exit 1
fi

echo "Generating a new SSH key for GitHub..."

# Generate key (will prompt before overwrite)
ssh-keygen -t ed25519 -C "$EMAIL" -f "$HOME/.ssh/id_ed25519"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Ensure ssh config exists
mkdir -p "$HOME/.ssh"
touch "$HOME/.ssh/config"

# Append config only if not already present
if ! grep -q "IdentityFile ~/.ssh/id_ed25519" "$HOME/.ssh/config"; then
  cat >> "$HOME/.ssh/config" <<EOF

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

# Add key to agent + keychain
ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"

echo
echo "Public key copied to clipboard. Add it to GitHub:"
pbcopy < "$HOME/.ssh/id_ed25519.pub"
