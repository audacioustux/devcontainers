#!/usr/bin/env bash

set -eax

source dev-container-features-test-lib

pkgs=(
    ripgrep
    bat
    exa
    delta
    hyperfine
    fd-find
    zoxide
    neovim
    python3-neovim
    httpie
    fzf
    socat
    parallel
    gum
)

for pkg in "${pkgs[@]}"; do
    check "$pkg" "which $pkg"
done

reportResults