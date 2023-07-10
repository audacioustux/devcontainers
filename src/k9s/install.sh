#!/usr/bin/env bash

set -eax

sudo -iu $_REMOTE_USER <<EOF
    curl -sS https://webinstall.dev/k9s | bash
EOF
