#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

# distribute dotfiles
## init.vim
mkdir -p ~/.config/nvim
ln -s $DOTFILEDIR/init.vim ~/.config/nvim/init.vim
