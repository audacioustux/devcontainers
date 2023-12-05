#!/usr/bin/env bash

set -eax

sudo -E -u $_REMOTE_USER zsh <<EOF
    if ${USE_BINSTALL:-false}; then
        curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
        cargo binstall --no-confirm --no-symlinks ${CRATES:?}
    else
        cargo install ${CRATES:?}
    fi
EOF