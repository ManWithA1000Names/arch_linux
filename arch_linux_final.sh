#!/bin/bash

timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
sudo echo "installing brave"
sudo aura --noconfirm -A "brave-bin" &>/dev/null &
lvim ~/.config/lvim/config.lua
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
