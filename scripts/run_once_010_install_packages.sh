#!/bin/bash

function install_brew() {
  if [[ $(uname) == 'Darwin' ]]; then
    echo 'Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  elif [[ $(uname) == 'Linux' ]]; then
    echo 'Installing linuxbrew...'
    git clone --depth 1 https://github.com/Homebrew/brew "$HOME/.linuxbrew/Homebrew"
    mkdir "$HOME/.linuxbrew/bin"
    ln -s "$HOME/.linuxbrew/Homebrew/bin/brew" "$HOME/.linuxbrew/bin"
    eval $("$HOME/.linuxbrew/bin/brew" shellenv)
  fi
  brew update
}

if [[ -z $(command -v brew) ]]; then
  install_brew
fi
yes | brew bundle --global
