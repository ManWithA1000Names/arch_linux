#!/bin/bash
lxappearance &
sudo aura --noconfirm -A "brave-bin"
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
sed -i '$ d' .bashrc
