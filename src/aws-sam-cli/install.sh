#!/usr/bin/env bash

set -eax

ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then ARCH=arm64; fi

install_sam_cli(){
    echo "Installing AWS SAM cli..."

    local artifact="aws-sam-cli-linux-${ARCH?}.zip"

    curl -sLO "https://github.com/aws/aws-sam-cli/releases/latest/download/$artifact"

    unzip $artifact
    ./install
}

install_sam_cli