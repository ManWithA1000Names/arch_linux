#!/bin/bash

timedatectl set-timezone "Europe/Athens"
lxappearance-gkt3 &>/dev/null &
rm -rf ~/.config/lvim/
gh auth login
gh repo clone lvim_config ~/.config/lvim
lvim +PackerSync +q
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
