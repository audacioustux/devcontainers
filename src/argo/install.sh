#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

install_argocd_cli(){
    echo "Installing argocd cli..."

    local artifact="argocd-linux-${ARCH?}"

    curl -sLO https://github.com/argoproj/argo-cd/releases/latest/download/$artifact

    chmod +x $artifact
    sudo mv $artifact /usr/local/bin/argocd
}

install_argo_cli(){
    echo "Installing argo cli..."

    local artifact="argo-linux-${ARCH?}.gz"

    curl -sLO https://github.com/argoproj/argo-workflows/releases/latest/download/$artifact

    gunzip $artifact

    chmod +x $artifact
    sudo mv $artifact /usr/local/bin/argo
}

if [ "$ARGOCD" = true ]; then install_argocd_cli; fi
if [ "$ARGO" = true ]; then install_argo_cli; fi
