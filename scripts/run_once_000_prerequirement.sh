#!/bin/bash
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
