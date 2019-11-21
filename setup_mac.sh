#!/bin/bash

# before ansible provisioning
# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# tap
brew tap caskroom/cask
brew tap sanemat/font

# install ansible
brew install ansible hub ripgrep bat fzf tree jq docker tig pipenv node java
brew install neovim --HEAD
brew cask install visual-studio-code iterm2 google-chrome firefox google-japanese-ime virtualbox vagrant dbeaver-community slack coteditor
brew install ricty

cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
