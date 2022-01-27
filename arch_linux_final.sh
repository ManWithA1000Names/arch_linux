#!/bin/bash
cd ~ || exit 1
sudo aura -A "brave-bin" "rofi-git"
gh auth login
git clone https://github.com/ManWithA1000Names/dear-configs
cd dear-configs || exit 0
./deploy.fish
cd ~ || exit
sudo rm -rf ./arch_linux_final.sh
lxappearance
awesome-client "awesome.restart"
