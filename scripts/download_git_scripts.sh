#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
source "${SCRIPT_DIR}/common.sh"

if [[ ! -e "$HOME/.git-completion.bash" ]]; then
  err '==> .git-completion.bash is not found'
  ok '==> Downloading .git-completion.bash...'
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "$HOME/.git-completion.bash"
else
  ok '==> .git-completion.bash is detected'
fi

if [[ ! -e "$HOME/.git-prompt.sh" ]]; then
  err '==> .git-prompt.sh is not found'
  ok '==> Downloading .git-prompt.sh...'
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o "$HOME/.git-prompt.sh"
else
  ok '==> .git-prompt.sh is detected'
fi

