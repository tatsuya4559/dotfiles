#!/bin/bash

DOTFILEDIR=$(cd $(dirname $0); pwd)

function distribute() {
    rm -f ~/.$1
    ln -s $DOTFILEDIR/home/$1 ~/.$1
}

# config
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
for file in $(ls $DOTFILEDIR/config/); do
    rm -rf ~/.config/${file}
    ln -s $DOTFILEDIR/config/${file} ~/.config/${file}
done

# home
for file in $(ls $DOTFILEDIR/home/); do
    distribute ${file}
done
