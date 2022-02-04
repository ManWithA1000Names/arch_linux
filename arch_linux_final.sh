#!/bin/bash
lxappearance &
timedatectl set-timezone "Europe/Athens"
sudo aura --noconfirm -A "brave-bin"
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
sed -i '$ d' .bashrc
