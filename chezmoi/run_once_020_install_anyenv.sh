#!/bin/bash
anyenv install --init
exec $SHELL -l

anyenv install pyenv
exec $SHELL -l
pyenv install 3.9.11

anyenv install nodenv
exec $SHELL -l
nodenv install 16.14.2

anyenv install goenv
exec $SHELL -l
goenv install 1.18

anyenv install tfenv
exec $SHELL -l
tfenv install 1.1.5
