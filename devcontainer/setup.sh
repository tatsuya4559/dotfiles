#!/bin/bash
set -eu

rm ~/.bashrc
make run
make link
make minpac

# install gopls
go install golang.org/x/tools/gopls@latest

# and install more tools I need

# - change PS1 in devcontainer
echo 'export PS1="\u@\h:\W \\$ "' >> "$HOME/.bashrc"
