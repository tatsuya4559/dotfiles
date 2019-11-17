#!/bin/bash

# 冪等性を維持するために一回だけ実行したいコマンドを隔離する
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
