#!/usr/bin/env bash

set -eax

echo "Installing flyctl..."
sudo -E -u $_REMOTE_USER zsh <<EOF
  if [ "$VERSION" = "latest" ]; then
    sudo curl -L https://fly.io/install.sh | sh
  else
    sudo curl -L https://fly.io/install.sh | sh -s "$VERSION"
  fi
EOF