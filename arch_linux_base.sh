#!/bin/bash

####################
### Base Install ###
####################
git clone -b server https://github.com/christitustech/archtitus
cd archtitus || exit 1
./archtitus.sh
cd ..
new_home="/mnt/home/$(ls /mnt/home)"
cp ./arch_linux_setup.sh "$new_home"
echo "$new_home/arch_linux_setup" >>"$new_home/.bashrc"
echo "this is the new home directory: $new_home"
####### end ########

###############################
# reboot needs to happen here #
###############################
echo ""
echo ""
echo ""
echo -n "Shutdown to remove installation media and start setup script? [Y/n]: "
read -r reboot_now
if [[ "$reboot_now" == "n" || "$reboot_now" == "N" || "$reboot_now" == "no" || "$reboot_now" == "NO" || "$reboot_now" == "No" || "$reboot_now" == "nO" ]]; then
	exit 0
else
	echo "Shutting down to start setup script :)"
	poweroff
fi
