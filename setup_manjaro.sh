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

################################################################################
# Install apps
################################################################################
# install by pacman
## install CLI tools
sudo pacman -S --noconfirm yay xclip ripgrep bat tig fzf neovim hub jq ghq
sudo pacman -S --noconfirm vagrant virtualbox docker docker-compose
sudo pacman -S --noconfirm python-neovim python-pipenv
yay -S ttf-cica

## install GUI tools
sudo pacman -S --noconfirm synapse
yay -S --noconfirm google-chrome visual-studio-code-bin meld

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

# upgrade packages
sudo pacman -Syu
