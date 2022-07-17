#!/bin/bash
set -eu

rm ~/.bashrc
make run
make link
make minpac

# install gopls
go install golang.org/x/tools/gopls@latest

# TODO:
# - direnv
# - install go tools
# - change PS1 in devcontainer
