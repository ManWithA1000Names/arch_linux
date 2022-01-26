#!/bin/bash

####################
### Base Install ###
####################
pacman -Sy git
git clone -b server https://www.github.com/christitustech/archtitus
cd archtitus || exit 1
./archtitus.sh
echo "$HOME/arch_linux/arch_linux_setup" >>.bashrc
####### end ########

###############################
# reboot needs to happen here #
###############################
echo ""
echo -n "Shutdown to remove installation media and start setup script? [Y/n]: "
read -r reboot_now
if [[ "$reboot_now" == "n" || "$reboot_now" == "N" || "$reboot_now" == "no" || "$reboot_now" == "NO" || "$reboot_now" == "No" || "$reboot_now" == "nO" ]]; then
	exit 0
else
	echo "Shutting down to start setup script :)"
	poweroff
fi
