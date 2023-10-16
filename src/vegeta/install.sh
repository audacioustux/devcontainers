#!/usr/bin/env bash

set -eax

echo "Installing vegeta..."
local artifact="vegeta_${version}_linux_${ARCH?}.tar.gz"

curl -sLO https://github.com/tsenart/vegeta/releases/latest/download/$artifact

tar xvf $artifact
rm $artifact

chmod +x vegeta
mv vegeta /usr/local/bin/vegeta
