#!/usr/bin/env bash

set -eax

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
# Enable bash-completion for task
/usr/local/bin/task --completion bash | sudo tee /etc/bash_completion.d/task > /dev/null
# Enable zsh-completion for task
/usr/local/bin/task --completion zsh | sudo tee /usr/local/share/zsh/site-functions/_task > /dev/null
