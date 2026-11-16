#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "user is vscode" grep vscode <(whoami)

check "pack is on the PATH" command -v pack
check "pack reports the pinned version" bash -c 'pack --version | grep -q "0.40.11"'

reportResults
