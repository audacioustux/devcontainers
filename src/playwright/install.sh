#!/usr/bin/env bash

set -eax

apt-get update -qq
npm i -D @playwright/test

sudo -E -u $_REMOTE_USER zsh <<EOF
    npx -q playwright install && npx playwright install-deps
EOF