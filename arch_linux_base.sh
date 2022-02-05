#!/bin/bash

####################
### Base Install ###
####################
git clone -b server https://github.com/christitustech/archtitus
cd archtitus || exit 1
./archtitus.sh
cd ..
new_user="$(ls /mnt/home)"
new_home="/mnt/home/$new_user"
mv ~/arch_linux/arch_linux_setup.sh "$new_home"
mv ~/arch_linux/arch_linux_final.sh "$new_home"
mv ~/arch_linux/install_photo_gimp.sh "$new_home"
mv ~/arch_linux/setup_bluetooth.sh "$new_home"
mv ~/arch_linux/brave_setup.sh "$new_home"
mv ~/arch_linux/nightTab.json "$new_home"
mv ~/arch_linux/avatar.png "$new_home"
mv ~/arch_linux/background.jpg "$new_home"
mv ~/arch_linux/Kripton.tar.xz "$new_home"
mv ~/arch_linux/volantes_light_cursors.tar.gz "$new_home"
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
