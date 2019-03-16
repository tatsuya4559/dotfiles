#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

# distribute dotfiles
## init.vim
mkdir -p ~/.config/nvim
ln -s $DOTFILEDIR/init.vim ~/.config/nvim/init.vim
ln -s $DOTFILEDIR/dein.toml ~/.config/nvim/dein.toml
ln -s $DOTFILEDIR/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
