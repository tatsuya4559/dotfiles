#!/bin/bash

# clone dotfiles
echo 'Cloning dotfiles...'
if [[ ! -d $HOME/dotfiles ]]; then
  git clone https://github.com/tatsuya4559/dotfiles.git $HOME/dotfiles
fi
cd $HOME/dotfiles

# install homebrew
echo 'Installing homebrew...'
if [[ -z `command -v brew` ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

# install apps
echo 'Installing apps...'
brew tap homebrew/bundle
brew bundle

# install git utils
if [[ ! -f $HOME/.git-completion.bash ]]; then
  echo 'download .git-completion.bash'
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash
  chmod a+x $HOME/.git-completion.bash
fi
if [[ ! -f $HOME/.git-prompt.sh ]]; then
  echo 'download .git-prompt.sh'
  curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o $HOME/.git-prompt.sh
  chmod a+x $HOME/.git-prompt.sh
fi

# distribute dotfiles
echo 'Distributing dotfiles...'
copy() {
  if [[ -e $HOME/$1 ]]; then
    echo "skip copying: $HOME/$1 exists"
  else
    echo "copy $HOME/dotfiles/$1 to $HOME/$1"
    cp $HOME/dotfiles/$1 $HOME/$1
  fi
}

symlink() {
  if [[ -e $HOME/$1 ]]; then
    echo "skip making link: $HOME/$1 exists"
  else
    echo "make link $HOME/dotfiles/$1 to $HOME/$1"
    ln -s $HOME/dotfiles/$1 $HOME/$1
  fi
}

copy .bash_profile
copy .bashrc
copy .gitconfig
copy .vimrc
symlink .inputrc
symlink .tmux.conf
symlink .tigrc

[[ ! -d $HOME/.vim/pack/minpac ]] && mkdir -p $HOME/.vim/pack/minpac/{start,opt}
[[ ! -d $HOME/.vim/pack/minpac/opt/minpac ]] && git clone https://github.com/k-takata/minpac.git $HOME/.vim/pack/minpac/opt/minpac
symlink .vim/ultisnips
symlink .vim/after

echo 'DONE!!'
