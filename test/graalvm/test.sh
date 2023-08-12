#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "$bin" command -v java
check "$bin" command -v gu

reportResults