#!/bin/bash
set -eu

ok() {
  tput -T xterm setaf 2
  echo "$@"
  tput -T xterm sgr0
}

err() {
  tput -T xterm setaf 1
  echo "$@"
  tput -T xterm sgr0
}
