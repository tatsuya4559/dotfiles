#/bin/bash
sudo apt update && sudo apt upgrade -y

# install linuxbrew
sudo apt install -y build-essential procps curl file git
git clone --depth 1 https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)
echo 'eval $(~/.linuxbrew/bin/brew shellenv)' >> ~/.bash_profile

# install apps
brew install tmux
brew install vim
brew install pyenv
brew install go

# clone this repository
git clone https://github.com/tatsuya4559/dotfiles.git

# copy dotfiles
cd dotfiles
cp .inputrc ~
cp .bashrc ~
cp .gitconfig ~
ln -s `pwd`/.tmux.conf ~/.tmux.conf
cp .vimrc ~
ln -s `pwd`/.vim/ultisnips ~/.vim/UltiSnips

# clone minpac
git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

# manual
# put symlink for diff-highlight
# install go-imports
# add $HOME/go to PATH
