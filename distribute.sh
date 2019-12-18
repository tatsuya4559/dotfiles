#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

function distribute() {
    rm -f ~/.$1
    ln -s $DOTFILEDIR/home/$1 ~/.$1
}

# neovim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
ln -s $DOTFILEDIR/vim/init.vim ~/.config/nvim/init.vim
ln -s $DOTFILEDIR/vim/rc ~/.config/nvim/rc
ln -s $DOTFILEDIR/vim/coc-settings.json ~/.config/nvim/coc-settings.json

# bash, tig, git
for file in $(ls $DOTFILEDIR/home/); do
    distribute ${file}
done
