#!/bin/bash

sudo aura --noconfirm -A "brave-bin" &>/dev/null &
timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
