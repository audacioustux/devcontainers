#!/usr/bin/env bash

set -eax

ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then ARCH=arm64; fi

install_vegeta(){
    echo "Installing vegeta..."
    local repo="tsenart/vegeta"
    local version=`curl -s https://api.github.com/repos/${repo}/releases/latest | jq -r .tag_name | sed 's/v//'`
    local artifact="vegeta_${version}_linux_${ARCH?}.tar.gz"
    
    curl -sLO https://github.com/tsenart/vegeta/releases/download/v${version}/${artifact}
    
    tar xvf $artifact
    rm $artifact
    
    chmod +x vegeta
    mv vegeta /usr/local/bin/vegeta
}

install_vegeta