#/bin/bash
sudo apt update && sudo apt upgrade -y
cd $HOME

# install golang
# sudo tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz
# echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bash_profile

# install python build env
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile

# install python
. ~/.bash_profile
pyenv install python 3.8.5

# clone this repository
git clone https://github.com/tatsuya4559/dotfiles.git

# copy dotfiles
cd dotfiles
cp .inputrc ~
cp .bashrc ~
cp .gitconfig ~
ln -s `pwd`/.tmux.conf ~/.tmux.conf

cp .vimrc ~
mkdir ~/.config/nvim
ln -s ~/.vimrc ~/.confing/nvim/init.vim
ln -s `pwd`/.vim/ultisnips ~/.confing/nvim/Ultisnips

# install apps
sudo apt install -y tmux neovim python-neovim
