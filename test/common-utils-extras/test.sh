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
    gumsdsd
)

for pkg in "${pkgs[@]}"; do
    check "$pkg" "which $pkg"
done

reportResults