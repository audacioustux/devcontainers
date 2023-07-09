#!/usr/bin/env bash

set -eax

sudo -iu $_REMOTE_USER <<EOF
    curl -fsSL https://get.pulumi.com | sh
EOF
