#!/bin/bash
set -eu

rm ~/.bashrc
make link
make minpac
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o "$HOME/.git-completion.bash"
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o "$HOME/.git-prompt.sh"

# install gopls
go install golang.org/x/tools/gopls@latest

# TODO:
# - direnv
# - install go tools
# - change PS1 in devcontainer
