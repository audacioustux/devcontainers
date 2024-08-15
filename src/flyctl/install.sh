#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

echo "Installing flyctl..."

# get the download link of github release from the api
URL=$(curl -s https://api.fly.io/app/flyctl_releases/linux/$ARCH/$VERSION)

# download and extract the binary
curl -fL $URL | tar -xz

# make the binary executable and create a symlink
chmod +x flyctl
ln -s flyctl fly

# move the binary and symlink to /usr/local/bin
mv fly /usr/local/bin/fly
mv flyctl /usr/local/bin/flyctl
