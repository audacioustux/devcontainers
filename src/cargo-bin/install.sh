#!/usr/bin/env bash

set -eax

sudo -E -u $_REMOTE_USER zsh <<EOF
    cargo install ${CRATES:?}
EOF