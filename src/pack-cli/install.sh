#!/usr/bin/env bash

set -eax

apt-get update -qq
apt-get install -yqq --no-install-recommends software-properties-common

add-apt-repository ppa:cncf-buildpacks/pack-cli -y
apt-get install pack-cli

# cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*
