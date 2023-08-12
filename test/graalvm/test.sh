#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

bins=(
    java
    gu
)

for bin in "${bins[@]}"; do
    check "$bin" command -v "$bin"
done

reportResults