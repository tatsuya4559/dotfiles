#!/bin/bash
set -eu

ok() {
  tput setaf 2
  echo "$@"
  tput sgr0
}

err() {
  tput setaf 1
  echo "$@"
  tput sgr0
}

if [[ $(uname) == 'Linux' ]]; then
  if [[ -n $(command -v apt) ]]; then
    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y \
      build-essential \
      procps \
      curl \
      file \
      git \
      curl
  fi
fi

# Install homebrew / linuxbrew
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

# Download git scripts
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
