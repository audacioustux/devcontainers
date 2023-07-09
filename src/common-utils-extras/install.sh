#!/usr/bin/env bash

set -eax

# add repo for gum
mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list

apt-get update -qq
apt-get install -yqq --no-install-recommends \
    ripgrep \
    bat \
    exa \
    hyperfine \
    fd \
    zoxide \
    neovim \
    python3-neovim \
    httpie \
    fzf \
    socat \
    parallel \
    gum

# create symlinks for bat and fd, as they are called batcat and fdfind in Ubuntu
sudo -iu $_REMOTE_USER <<EOF
    mkdir -p ~/.local/bin
    ln -s $(which batcat) ~/.local/bin/bat
    ln -s $(which fdfind) ~/.local/bin/fd
EOF