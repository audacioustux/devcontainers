#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "user is vscode" grep vscode <(whoami)

bins=(
    wat2wasm
    wasm2wat
    wassm-opt
    emcc
)

for bin in "${bins[@]}"; do
    check "$bin" command -v "$bin"
done

reportResults
