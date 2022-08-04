#!/bin/bash

####################
### Base Install ###
####################
git clone https://github.com/christitustech/archtitus
cd ./archtitus || exit 1
./archtitus.sh
new_user="$(ls /mnt/home)"
new_home="/mnt/home/$new_user"
mv arch_linux_setup.sh "$new_home"
mv arch_linux_final.sh "$new_home"
mv install_photo_gimp.sh "$new_home"
mv setup_bluetooth.sh "$new_home"
mv nightTab.json "$new_home"
mv avatar.png "$new_home"
mv background.jpg "$new_home"
mv Kripton.tar.xz "$new_home"
mv volantes_light_cursors.tar.gz "$new_home"
mv packages.txt "$new_home"
sed -i "s/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /mnt/etc/sudoers
arch-chroot /mnt /usr/bin/runuser -u "$new_user" -- "/home/$new_user/arch_linux_setup.sh"
sed -i "s/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/" /mnt/etc/sudoers
sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /mnt/etc/sudoers
####### end ########

###############################
# reboot needs to happen here #
###############################
echo -n "Reboot to user? [Y/n] "
read -r line
if ! [[ "${line,,}" == "no" || "${line,,}" == "n" ]]; then
	poweroff
fi
