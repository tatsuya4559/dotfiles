#!/bin/bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"
source "${SCRIPT_DIR}/common.sh"

if [[ -z $(command -v brew) ]]; then
  err '==> brew is not found'
  if [[ $(uname) == 'Darwin' ]]; then
    ok '==> Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  elif [[ $(uname) == 'Linux' ]]; then
    ok '==> Installing linuxbrew...'
    git clone --depth 1 https://github.com/Homebrew/brew "$HOME/.linuxbrew/Homebrew"
    mkdir "$HOME/.linuxbrew/bin"
    ln -s "$HOME/.linuxbrew/Homebrew/bin/brew" "$HOME/.linuxbrew/bin"
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
  fi
  brew update
else
  ok '==> brew is detected'
fi
