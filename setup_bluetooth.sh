#!/bin/bash

if ! lsmod | grep "btusb"; then
	sudo modprobe "btusb"
	echo "# Load bluetooth kernel module at boot by systemd" | sudo tee "/etc/modules-load.d/btusb.conf" &>/dev/null
	echo "btusb" | sudo tee -a "/etc/modules-load.d/btusb.conf" &>/dev/null
fi
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo sed -i 's/# ?AutoEnable=false/AutoEnable=true/' /etc/bluetooth/main.conf
blueman-manager
