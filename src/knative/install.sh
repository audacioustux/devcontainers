#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

install_knative_cli(){
    echo "Installing knative cli..."

    local artifact="kn-linux-${ARCH?}"

    curl -sLO "https://github.com/knative/client/releases/latest/download/$artifact"

    chmod +x $artifact
    mv $artifact /usr/local/bin/kn
    kn version
}

install_knative_func_cli(){
    echo "Installing knative func cli..."

    local artifact="func_linux_${ARCH?}"
    local version="1.11.0"

    curl -sLO "https://github.com/knative/func/releases/latest/download/$artifact"

    chmod +x $artifact
    mv $artifact /usr/local/bin/kn-func
    kn-func version
}

install_knative_cli
install_knative_func_cli