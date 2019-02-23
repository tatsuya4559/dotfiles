#!/bin/bash
# 起動時に一度だけ実行されるprovisioning

# Exit if already bootstrapped
test -f /etc/bootstrapped && exit

# =================実行したいスクリプト===================

# =================日本語環境の構築===================
sudo timedatectl set-timezone Asia/Tokyo  # タイムゾーン設定
sudo cat << 'EOF' | sudo tee /etc/locale.conf
LANG=ja_JP.UTF8
LC_NUMERIC=ja_JP.UTF8
LC_TIME=ja_JP.UTF8
LC_MONETARY=ja_JP.UTF8
LC_PAPER=ja_JP.UTF8
LC_MEASUREMENT=ja_JP.UTF8
EOF
sudo mv /etc/locale.gen{,.bac}
echo ja_JP.UTF-8 UTF-8 | sudo tee /etc/locale.gen
sudo locale-gen
sudo pacman -Syy


# =================pacman強化===================
## =================mirrorlist書き換え===================
sudo pacman -S --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist{,.bac}
sudo reflector --verbose --country 'Japan' -l 10 --sort rate --save /etc/pacman.d/mirrorlist


# =================GUI環境===================
sudo pacman -S --noconfirm xorg-xinit lightdm-gtk-greeter
yes 'all' | sudo pacman -S --noconfirm xfce4 lightdm
sudo systemctl enable lightdm.service
# /etc/systemd/system/default.targetのリンクをmulti-user.targetからgraphical.targetに変える
sudo systemctl set-default graphical.target


## =================フォントとインプットメソッドのインストール===================
yaourt -S --noconfirm otf-takao
yes 'all' | sudo pacman -S --noconfirm fcitx-im fcitx-configtool fcitx-mozc

sudo cat << 'EOF' > ${HOME}/.xprofile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”
EOF

## =================自動ログイン===================
sudo sed -ie 's/#autologin-user=/autologin-user=vagrant/' /etc/lightdm/lightdm.conf

sudo groupadd -r autologin
sudo gpasswd -a vagrant autologin
# 一回目のログインはユーザー名とパスワード(どちらもvagrnat)打たないといけない


# =================その他好きなもの===================
sudo pacman -S --noconfirm neovim git python-pipenv
sudo pip install neovim

# yaourt -S --noconfirm man-pages-ja-git gitflow-avh-git
# man-page-ja-git: 日本語man
# gitflow-avh-git: git-flow tools


# ================End of bootstraping====================
# 実行したときの時間書き込み
cat $0 | sudo tee /etc/bootstrapped


# **********First Login**********
#         username: vagrant
#         password: vagrant
# *******************************
sudo reboot
