#!/bin/bash
cd ~ || exit 1
sudo aura -A "brave-bin"
sudo aura -A "rofi-git"
gh auth login
gh repo clone dear-configs
cd dear-configs || exit 0
./deploy.fish
timedatectl set-timezone "Europe/Athens"
fisher install ilancosman/tide
lxappearance
awesome-client "awesome.restart()"
cd ~ && sudo rm -rf ./arch_linux_final.sh
killall kitty
