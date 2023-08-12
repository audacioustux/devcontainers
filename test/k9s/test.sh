#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

bins=(
    k9s
)

for bin in "${bins[@]}"; do
    check "$bin" command -v "$bin"
done

reportResults