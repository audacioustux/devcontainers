#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

# add repo for gum
mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list

apt-get update -qq
apt-get install -yqq --no-install-recommends \
    ripgrep \
    bat \
    fd-find \
    zoxide \
    neovim \
    python3-neovim \
    httpie \
    fzf \
    socat \
    parallel \
    gum \
    cloc \
    moreutils \
    pkg-config \
    inotify-tools

# create symlinks for bat and fd, as they are called batcat and fdfind in Ubuntu
sudo -iu $_REMOTE_USER <<EOF
    mkdir -p ~/.local/bin
    ln -s $(which batcat) ~/.local/bin/bat
    ln -s $(which fdfind) ~/.local/bin/fd
EOF

# install yq
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_$ARCH -O /usr/bin/yq 
sudo chmod +x /usr/bin/yq

# cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*
