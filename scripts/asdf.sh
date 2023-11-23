#!/bin/bash
set -eu

plugin_add_and_install() {
  local -r package="$1"
  asdf plugin add $package
  asdf install $package latest
}

plugin_add_and_install python
plugin_add_and_install golang
plugin_add_and_install terraform
