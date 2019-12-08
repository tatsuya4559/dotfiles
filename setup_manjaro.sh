#!/bin/bash
################################################################################
# Prepare for setting up
################################################################################
# set fastest mirror and update package
sudo pacman-mirrors --fasttrack && sudo pacman -Syy

################################################################################
# Basic settings
################################################################################
# install japanese font
sudo pacman -S --noconfirm otf-ipafont adobe-source-han-sans-jp-fonts
pushd ~/Downloads/
git clone https://github.com/edihbrandon/RictyDiminished.git
sudo mkdir /usr/share/fonts/TTF/RictyDiminished
sudo mv RictyDiminished/*.ttf /usr/share/fonts/TTF/RictyDiminished/
sudo fc-cache -fv
rm -rf RictyDiminished
popd

# enable japanese IME(needs GUI setting and reboot)
yes | sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc
echo export GTK_IM_MODULE=fcitx >> .xprofile
echo export QT_IM_MODULE=fcitx >> .xprofile
echo export XMODIFIERS="@im=fcitx" >> .xprofile
#fcitx-configtool&

# swap ctrl and capslock
## for consol
sudo mkdir -p /usr/local/share/kbd/keymaps
sudo cp /usr/share/kbd/keymaps/i386/qwerty/us.map.gz /usr/local/share/kbd/keymaps
sudo gunzip /usr/local/share/kbd/keymaps/us.map.gz
echo "keycode 29 = Caps_Lock" >> /usr/local/share/kbd/keymaps/us.map
echo "keycode 58 = Control" >> /usr/local/share/kbd/keymaps/us.map
echo "KEYMAP=/usr/local/share/kbd/keymaps/us.map" | sudo tee -a /etc/vconsole.conf
## for xorg
localectl --no-convert set-x11-keymap us pc105 "" ctrl:swapcaps

# set Emacs key-theme
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
#gsettings set org.gnome.desktop.interface gtk-key-theme "Default"

# clone my dotfiles
pushd ~
git clone https://github.com/tatsuya4559/dotfiles.git
popd

################################################################################
# Install apps
################################################################################
# install by pacman
## install CLI tools
sudo pacman -S --noconfirm yay xclip ripgrep bat tig fzf neovim hub jq
sudo pacman -S --noconfirm vagrant virtualbox docker docker-compose
sudo pacman -S --noconfirm python-neovim python-pipenv

## install GUI tools
sudo pacman -S --noconfirm terminator gnumeric synapse dbeaver
yay -S --noconfirm gitkraken google-chrome visual-studio-code-bin #, meld

# install from AUR
## install google-chrome
#pushd ~/Downloads/
#git clone https://aur.archlinux.org/google-chrome.git
#cd google-chrome/
#yes 'Y' | makepkg -s
#yes 'Y' | sudo pacman -U *.pkg.tar.xz
#popd

# install nice gtk/icon themes
pushd ~/Downloads/
## gtk theme
git clone https://github.com/EliverLara/Nordic.git
mkdir ~/.themes
cp -r ~/Downloads/Nordic ~/.themes
rm -rf ~/Downloads/Nordic

## icon theme
git clone https://github.com/numixproject/numix-icon-theme-circle.git
mkdir ~/.icons
cp -r ~/Downloads/numix-icon-theme-circle/Numix-Circle* .icons/
rm -rf ~/Downloads/numix-icon-theme-circle
popd

# git settings
git config --global user.name "tatsuya4559"
git config --global user.email "tatsuya.k1029@gmail.com"
git config --global core.editor "nvim"

# realize pbcopy, pbpaste
# (want to prepare .bashrc in dotfiles)
echo "alias pbcopy='xclip -selection c'" >> ~/.bashrc
echo "alias pbpaste='xclip -selection c -o'" >> ~/.bashrc
echo "alias vimdiff='nvim -d'" >> ~/.bashrc
echo "alias vim='nvim'" >> ~/.bashrc
echo "set completion-ignore-case on" >> ~/.inputrc
# uninstall some pre-install apps

# upgrade packages
sudo pacman -Syu
