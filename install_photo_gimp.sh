#!/bin/bash

gimp &>/dev/null &
gimp_pid=$!
curl https://codeload.github.com/Diolinux/PhotoGIMP/tar.gz/refs/tags/1.0 --output PhotoGIMP.tar.gz
tar -xf ./PhotoGIMP.tar.gz
rm ./PhotoGIMP.tar.gz
sleep 2
kill $gimp_pid
if cd PhotoGIMP-1.0; then
	rm -rf ~/.config/GIMP/*
	mv .var/app/org.gimp.GIMP/config/GIMP/2.10/ ../.config/GIMP/
	cd ..
	rm -rf PhotoGIMP-1.0
else
	rm -rf PhotoGIMP-1.0
fi
echo -n "remove install script? [Y/n]"
read -r line
if ! [[ "${line,,}" == "n" || "${line,,}" == "no" ]]; then
	rm -rf ~/install_photo_gimp.sh
fi
