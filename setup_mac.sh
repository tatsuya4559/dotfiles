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
brew "docker"
brew "docker-compose"
brew "fd"
brew "fzf"
brew "ghq"
brew "git"
brew "hub"
brew "jq"
brew "neovim", args: ["HEAD"]
brew "nvm"
brew "ripgrep"
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

# install git utils
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
chmod a+x ~/.git-completion.bash
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
chmod a+x ~/.git-prompt.sh

# clone dotfiles
echo 'Cloning dotfiles...'
export GHQ_ROOT=~/git
ghq get https://github.com/tatsuya4559/dotfiles

# distribute dotfiles
echo 'Set symlink of dotfiles...'
DOTFILEDIR=`ghq list -p tatsuya4559/dotfiles`

for file in $(ls ${DOTFILEDIR}/config/); do
  rm -rf ~/.config/${file}
  ln -s ${DOTFILEDIR}/config/${file} ~/.config/${file}
done

for file in $(find ${DOTFILEDIR} -name '\.*' -d 1 -type f); do
  rm -f ~/`basename ${file}`
  cp ${file} ~/`basename ${file}`
done

echo 'DONE!!'
