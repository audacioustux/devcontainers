#!/usr/bin/env bash

set -eax

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
# Enable bash-completion for task
/usr/local/bin/task --completion bash | sudo tee /etc/bash_completion.d/task > /dev/null