#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

# distribute dotfiles
## init.vim
if [ ! -e ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi
if [ -e ~/.config/nvim/init.vim ]; then
	rm -f ~/.config/nvim/init.vim
fi
ln -s $DOTFILEDIR/nvim/init.vim ~/.config/nvim/init.vim

## terminator
if [ ! -e ~/.config/terminator ]; then
	mkdir -p ~/.config/terminator
fi
if [ -e ~/.config/terminator/config ]; then
	rm -f ~/.config/terminator/config
fi
ln -s $DOTFILEDIR/terminator/config ~/.config/terminator/config
