#!/bin/bash
set -eu

ok() {
  if [[ -z $TERM ]]; then
    export TERM=xterm
  fi
  tput setaf 2
  echo "$@"
  tput sgr0
}

err() {
  if [[ -z $TERM ]]; then
    export TERM=xterm
  fi
  tput setaf 1
  echo "$@"
  tput sgr0
}
