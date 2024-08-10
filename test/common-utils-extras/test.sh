#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

bins=(
    rg
    bat
    fd
    zoxide
    nvim
    http
    fzf
    socat
    parallel
    gum
    yq
    cloc
)

for bin in "${bins[@]}"; do
    check "$bin" command -v "$bin"
done

reportResults
