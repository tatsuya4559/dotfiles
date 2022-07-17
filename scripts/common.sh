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
