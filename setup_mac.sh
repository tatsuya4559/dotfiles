#!/bin/bash

# install homebrew
echo 'Installing homebrew...'
if [ -z `command -v brew` ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

# install apps
echo 'Installing apps...'
cat <<EOF > ~/.Brewfile
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-versions"
tap "homebrew/core"
brew "docker"
brew "docker-compose"
brew "fd"
brew "fzf"
brew "ghq"
brew "gh"
brew "git"
brew "jq"
brew "tig"
brew "tmux"
brew "tldr"
brew "tree"
cask "dbeaver-community"
cask "firefox"
cask "google-chrome"
cask "google-japanese-ime"
cask "slack"
cask "visual-studio-code"
EOF
brew tap homebrew/bundle
brew bundle --global

# install git utils
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
chmod a+x ~/.git-completion.bash
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
chmod a+x ~/.git-prompt.sh

# dotfiles
git clone https://github.com/tatsuya4559/dotfiles ~/dotfiles

function copy() {
  rm -f ~/$1
  cp ~/dotfiles/$1 ~
}

copy .bash_profile
copy .bashrc
copy .inputrc
copy .gitconfig
copy .vimrc
copy .tmux.conf
copy .tigrc

mkdir -p ~/.vim/pack/minpac/{start,opt}
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
ln -s ~/dotfiles/.vim/ultisnips ~/.vim/ultisnips

echo 'DONE!!'
