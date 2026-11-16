#!/usr/bin/env bash

set -eax

# The `pack` CLI is distributed as a static-ish Go binary on GitHub Releases.
#
# We deliberately avoid the `ppa:cncf-buildpacks/pack-cli` PPA here: it only
# publishes packages for Ubuntu releases up to plucky (25.04), so it 404s on
# newer codenames such as questing (25.10) and resolute (26.04), which the
# `mcr.microsoft.com/devcontainers/base:ubuntu` image now ships.
#
# The release tarball is independent of the Ubuntu codename, so it works
# everywhere. See https://buildpacks.io/docs/tools/pack/ for the official
# install instructions.

PACK_VERSION="${VERSION:-latest}"

# The published archive names the architecture after "linux", and amd64
# builds are published without an architecture suffix at all.
ARCH=""
if [ "$(uname -m)" = "aarch64" ]; then ARCH="-arm64"; fi

if [ "${PACK_VERSION}" = "latest" ]; then
    # Resolve the latest release via the "latest" redirect rather than the
    # API, so that unauthenticated/rate-limited requests still work.
    PACK_VERSION=$(curl -fsSLI -o /dev/null -w '%{url_effective}' \
        https://github.com/buildpacks/pack/releases/latest | sed -E 's#.*/tag/v?##')
fi
PACK_VERSION="${PACK_VERSION#v}"
echo "Installing pack CLI v${PACK_VERSION} for $(uname -m)"

ARCHIVE="pack-v${PACK_VERSION}-linux${ARCH}.tgz"
BASE_URL="https://github.com/buildpacks/pack/releases/download/v${PACK_VERSION}"

curl -fsSL --retry 3 -o "/tmp/${ARCHIVE}" "${BASE_URL}/${ARCHIVE}"
curl -fsSL --retry 3 -o "/tmp/${ARCHIVE}.sha256" "${BASE_URL}/${ARCHIVE}.sha256"

# The published checksum file contains the bare hash followed by the file name.
EXPECTED=$(awk '{print $1}' "/tmp/${ARCHIVE}.sha256")
ACTUAL=$(sha256sum "/tmp/${ARCHIVE}" | awk '{print $1}')
if [ "${EXPECTED}" != "${ACTUAL}" ]; then
    echo "Checksum mismatch for ${ARCHIVE}: expected ${EXPECTED}, got ${ACTUAL}" >&2
    exit 1
fi

tar -C /usr/local/bin -xzf "/tmp/${ARCHIVE}" --no-same-owner pack
chmod +x /usr/local/bin/pack

rm -f "/tmp/${ARCHIVE}" "/tmp/${ARCHIVE}.sha256"

pack --version
