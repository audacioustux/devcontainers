#!/usr/bin/env bash

set -eax

apt-get update -qq
apt-get install -yqq --no-install-recommends \
    wabt \
    binaryen \
    emscripten
