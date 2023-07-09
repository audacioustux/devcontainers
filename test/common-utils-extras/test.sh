#!/usr/bin/env bash

set -eax

source dev-container-features-test-lib

bins=(
    rg
    bat
    exa
    delta
    hyperfine
    fd-find
    zoxide
    neovim
    httpie
    fzf
    socat
    parallel
    gums
)

# check if all bins are installed and executable
for bin in "${bins[@]}"; do
    if ! command -v "$bin" &> /dev/null; then
        reportError "$bin is not installed"
    fi
done

reportResults