#!/bin/bash
cd ~ || exit 1
sudo aura -A "brave-bin"
sudo aura -A "rofi-git"
gh auth login
gh repo clone dear-configs
cd dear-configs || exit 0
./deploy.fish
cd ~ || exit
sudo rm -rf ./arch_linux_final.sh
timedatectl set-timezone "Europe/Athens"
fisher install ilancosman/tide
lxappearance
awesome-client "awesome.restart()"
