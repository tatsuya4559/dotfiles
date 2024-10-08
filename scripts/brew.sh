#!/bin/bash
set -eu

insall() {
  case $(uname) in
    Darwin)
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ;;
    Linux)
      git clone --depth 1 https://github.com/Homebrew/brew "$HOME/.linuxbrew/Homebrew"
      mkdir "$HOME/.linuxbrew/bin"
      ln -s "$HOME/.linuxbrew/Homebrew/bin/brew" "$HOME/.linuxbrew/bin"
      echo 'eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"' >> ~/.bashrc
      eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
      ;;
    *)
      echo 'Unknown os' >&2
      exit 1
      ;;
  esac
}

bundle() {
  case $(uname) in
    Darwin)
      cat Brewfile.common Brewfile.mac | brew bundle --file=-
      ;;
    Linux)
      cat Brewfile.common | brew bundle --file=-
      ;;
    *)
      echo 'Unknown os' >&2
      exit 1
      ;;
  esac
}

insall
bundle
