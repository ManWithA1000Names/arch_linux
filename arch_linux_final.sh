#!/bin/bash

timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
kvantum &>/dev/null &
echo "gtk-decoration-layout=close,maximize,minimize:menu" >>~/.config/gtk-3.0/settings.ini
rm -rf ~/.config/lvim/
git clone https://github.com/manwitha1000names/lvim_config ~/.config/lvim
sed -i 's/source("debug")/-- source("debug")/' ~/.config/lvim/config.lua
lvim +PackerSync +q
sed -i 's/-- source("debug")/source("debug")' ~/.config/lvim/config.lua
gh auth login
wait
cd ~ && rm -rf ./arch_linux_final.sh
