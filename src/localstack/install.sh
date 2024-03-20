#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

install_localstack() {
    echo "Installing Localstack..."
    LATEST_VERSION=$(curl https://api.github.com/repos/localstack/localstack/releases/latest | grep -i "tag_name" | awk -F '"' '{print $4}' | sed 's/v//g')
    curl -Lo localstack-cli-${LATEST_VERSION}-linux-${ARCH}-onefile.tar.gz \
        https://github.com/localstack/localstack-cli/releases/download/v${LATEST_VERSION}/localstack-cli-${LATEST_VERSION}-linux-${ARCH}-onefile.tar.gz
    tar xvzf localstack-cli-${LATEST_VERSION}-linux-*-onefile.tar.gz -C /usr/local/bin
}

install_localstack