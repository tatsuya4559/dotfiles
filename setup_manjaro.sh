#!/bin/bash
# set fastest mirror
sudo pacman-mirrors -f 0
# update package
sudo pacman -Syy

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
git clone https://github.com/tatsuya4559/dotfiles.git

# install pipenv, vagrant, ripgrep, xclip
sudo pacman -S --noconfirm python-pipenv vagrant ripgrep xclip

# install neovim, terminator
sudo pacman -S --noconfirm neovim terminator

# realize pbcopy, pbpaste
# (want to prepare .bashrc in dotfiles)
echo "alias pbcopy='xclip -selection c'" >> ~/.bashrc
echo "alias pbpaste='xclip -selection c -o'" >> ~/.bashrc

# install google-chrome
pushd ~/Downloads/
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome/
makepkg -s
yes 'Y' | sudo pacman -U *.pkg.tar.xz
popd

# install nordic gtk theme
#dl zip from git
#mkdir ~/.theme
#unzip -d ~/.theme nordic.zip

# uninstall some pre-install apps

# upgrade packages
sudo pacman -Syu
