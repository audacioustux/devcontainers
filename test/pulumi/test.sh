#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "$bin" command -v pulumi

reportResults