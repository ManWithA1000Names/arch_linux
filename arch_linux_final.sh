#!/bin/bash
cd ~ || exit 1
sudo aura --noconfirm -A "brave-bin"
curl https://codeload.github.com/Diolinux/PhotoGIMP/tar.gz/refs/tags/1.0 --output PhotoGIMP.tar.gz
tar -xf ./PhotoGIMP.tar.gz
rm ./PhotoGIMP.tar.gz
mkdir -p ./.icons
mkdir -p .local/share/applications/
if cd PhotoGIMP-1.0; then
	cp .icons/* ../.icons/
	sed -i 's/Icon=.*/Icon=photogimp.png/' ~/.local/share/applications/org.gimp.GIMP.desktop
	rm -rf ~/.config/GIMP/*
	mv .var/app/org.gimp.GIMP/config/GIMP/2.10/ ../.config/GIMP/
	cd ..
	rm -rf PhotoGIMP-1.0
else
	rm -rf PhotoGIMP-1.0
fi
gh auth login
gh repo clone dear-configs
cd dear-configs || exit 0
./deploy.fish
timedatectl set-timezone "Europe/Athens"
fish -c "fisher install ilancosman/tide"
nextcloud &
albert &
lxappearance
wait
awesome-client "awesome.restart()"
cd ~ && sudo rm -rf ./arch_linux_final.sh
killall kitty
