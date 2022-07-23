#!/bin/bash

timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
kvantummanager &>/dev/null &
vlc &>/dev/null &
code &>/dev/null &
rm -rf ~/.config/lvim/
git clone https://github.com/manwitha1000names/lvim_config ~/.config/lvim
sed -i 's/source("debug")/-- source("debug")/' ~/.config/lvim/config.lua
lvim +PackerSync +q
sed -i 's/-- source("debug")/source("debug")' ~/.config/lvim/config.lua
gh auth login
wait
echo "gtk-decoration-layout=close,maximize,minimize:menu" >>~/.config/gtk-3.0/settings.ini
cd ~ && rm -rf ./arch_linux_final.sh
