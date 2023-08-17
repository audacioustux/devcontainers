#!/usr/bin/env bash

set -eax

ARCH=$(uname -m)
if [ "$ARCH" == "x86_64" ]; then
    curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
elif [ "$ARCH" == "aarch64" ]; then
    curl -fL "https://github.com/VirtusLab/coursier-m1/releases/latest/download/cs-aarch64-pc-linux.gz" | gzip -d > cs
else
    echo "Unsupported architecture: $(uname -m)"
    exit 1
fi

chmod +x cs
install -o root -g root -m 0755 cs /usr/local/bin/cs

sudo -E -u $_REMOTE_USER bash <<EOF
    cs setup -y -q
EOF
