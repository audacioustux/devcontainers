#!/usr/bin/env bash

set -eax

curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

install -m 755 kustomize /usr/local/bin/kustomize
