#!/usr/bin/env bash

set -eax

USER_HOME=$(eval echo ~$_REMOTE_USER)

export FLYCTL_INSTALL="$USER_HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

echo "Installing flyctl..."
sudo -E -u $_REMOTE_USER zsh <<EOF
  if [ "$VERSION" = "latest" ]; then
    curl -L https://fly.io/install.sh | sh
  else
    curl -L https://fly.io/install.sh | sh -s "$VERSION"
  fi
EOF
