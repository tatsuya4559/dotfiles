#!/bin/bash
set -eu

ok() {
  tput -T xterm setaf 2
  echo "$@"
  tput -T xterm sgr0
}

err() {
  if [[ -z $TERM ]]; then
    export TERM=xterm
  fi
  tput setaf 1
  echo "$@"
  tput sgr0
}
