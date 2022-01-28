#!/bin/bash

gimp &
gimp_pid=$!
curl https://codeload.github.com/Diolinux/PhotoGIMP/tar.gz/refs/tags/1.0 --output PhotoGIMP.tar.gz
tar -xf ./PhotoGIMP.tar.gz
rm ./PhotoGIMP.tar.gz
mkdir -p ./.icons
mkdir -p .local/share/applications/
sleep 2
kill $gimp_pid
if cd PhotoGIMP-1.0; then
	cp .icons/* ../.icons/
	sudo sed -i 's/Icon=.*/Icon=photogimp.png/' ~/usr/share/applications/gimp.desktop
	rm -rf ~/.config/GIMP/*
	mv .var/app/org.gimp.GIMP/config/GIMP/2.10/ ../.config/GIMP/
	cd ..
	rm -rf PhotoGIMP-1.0
else
	rm -rf PhotoGIMP-1.0
fi
