#!/bin/bash

timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
sudo aura --noconfirm -A "brave-bin" &>/dev/null &
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
