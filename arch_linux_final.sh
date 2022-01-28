#!/bin/bash
cd ~ || exit 1
sudo aura --noconfirm -A "brave-bin"
gh auth login
gh repo clone dear-configs
gh config set -h github.com git_protocol https
cd dear-configs || exit 0
./deploy.fish
timedatectl set-timezone "Europe/Athens"
fish -c "fisher install ilancosman/tide"
albert &
lxappearance
wait
lvim ~/.config/lvim/config.lua
awesome-client "awesome.restart()"
cd ~ && sudo rm -rf ./arch_linux_final.sh
killall kitty
