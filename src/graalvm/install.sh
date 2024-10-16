#!/usr/bin/env bash

set -eax

URL_BASE=https://download.oracle.com/graalvm/${JAVA}/${VERSION}

ARCH="$(uname -m)"
if [ "$ARCH" = "x86_64" ]; then
    ARCH="x64"
fi

JAVA_PKG="$URL_BASE"/graalvm-jdk-${JAVA}_linux-"${ARCH}"_bin.tar.gz
JAVA_SHA256=$(curl "$JAVA_PKG".sha256) 
curl --output /tmp/jdk.tgz "$JAVA_PKG"
echo "$JAVA_SHA256 */tmp/jdk.tgz" | sha256sum -c
mkdir -p "$JAVA_HOME"
tar --extract --file /tmp/jdk.tgz --directory "$JAVA_HOME" --strip-components 1