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
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
brew "ansible"
brew "bash"
brew "ctags"
brew "docker"
brew "docker-compose"
brew "fd"
brew "fzf"
brew "ghq"
brew "git", link: false
brew "hub"
brew "jq"
brew "neovim", args: ["HEAD"]
brew "node"
brew "pipenv"
brew "ripgrep"
brew "sd"
brew "tig"
brew "tmux"
brew "tree"
cask "dbeaver-community"
cask "firefox"
cask "font-cica"
cask "google-chrome"
cask "google-japanese-ime"
cask "iterm2"
cask "slack"
cask "visual-studio-code"
EOF
brew tap homebrew/bundle
brew bundle --global

# clone dotfiles
echo 'Cloning dotfiles...'
export GHQ_ROOT=~/git
ghq get https://github.com/tatsuya4559/dotfiles

# distribute dotfiles
echo 'Set symlink of dotfiles...'
DOTFILEDIR=`ghq list -p tatsuya4559/dotfiles`

for file in $(ls $DOTFILEDIR/config/); do
    rm -rf ~/.config/${file}
    ln -s $DOTFILEDIR/config/${file} ~/.config/${file}
done

for file in $(ls $DOTFILEDIR/home/); do
    rm -f ~/.${file}
    ln -s $DOTFILEDIR/home/${file} ~/.${file}
done

echo 'DONE!!'
