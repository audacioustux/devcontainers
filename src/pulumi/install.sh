#!/usr/bin/env bash

set -eax

ARCHITECTURE=""
case "$(dpkg --print-architecture)" in
    amd64) ARCHITECTURE=amd64;;
    arm64) ARCHITECTURE=arm64;;
    *) echo "unsupported architecture"; exit 1 ;;
esac

sudo -iu $_REMOTE_USER <<EOF
    curl -fsSL https://get.pulumi.com | sh
EOF

CRD2PULUMI_VERSION=$(curl -sSL https://api.github.com/repos/pulumi/crd2pulumi/releases/latest | jq -r ".tag_name")

curl -sSL -o /tmp/crd2pulumi.tar.gz https://github.com/pulumi/crd2pulumi/releases/download/${CRD2PULUMI_VERSION}/crd2pulumi-${CRD2PULUMI_VERSION}-linux-${ARCHITECTURE}.tar.gz
curl -sSL -o /tmp/crd2pulumi.tar.gz.asc https://github.com/pulumi/crd2pulumi/releases/download/${CRD2PULUMI_VERSION}/checksums.txt

cat /tmp/crd2pulumi.tar.gz.asc | grep "$(sha256sum /tmp/crd2pulumi.tar.gz | cut -d ' ' -f 1)"

mkdir -p /tmp/crd2pulumi
tar -xzf /tmp/crd2pulumi.tar.gz -C /tmp/crd2pulumi
install -o root -g root -m 0755 /tmp/crd2pulumi/crd2pulumi /usr/local/bin/crd2pulumi
