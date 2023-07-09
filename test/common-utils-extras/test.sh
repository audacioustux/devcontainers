#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

bins=(
    rg
    bat
    exa
    hyperfine
    fd
    zoxide
    nvim
    httpie
    fzf
    socat
    parallel
    gums
)

for bin in "${bins[@]}"; do
    check "$bin" command -v "$bin"
done

reportResults