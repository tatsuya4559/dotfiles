#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

# distribute dotfiles
## neovim
if [ ! -e ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
fi
if [ ! -e ~/.config/nvim/init.vim ]; then
    ln -s $DOTFILEDIR/vim/init.vim ~/.config/nvim/init.vim
    ln -s $DOTFILEDIR/vim/rc ~/.vim/rc
fi

## ideavim
if [ ! -e ~/.ideavimrc ]; then
    ln -s $DOTFILEDIR/vim/ideavimrc ~/.ideavimrc
fi

## terminator
#if [ ! -e ~/.config/terminator ]; then
    #mkdir -p ~/.config/terminator
#fi
#if [ -e ~/.config/terminator/config ]; then
    #rm -f ~/.config/terminator/config
#fi
#ln -s $DOTFILEDIR/terminator/config ~/.config/terminator/config
