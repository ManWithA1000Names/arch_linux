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
mv ~/arch_linux/Kripton.tar.xz "$new_home"
mv ~/arch_linux/volantes_light_cursors.tar.gz "$new_home"
arch-chroot /mnt
su "$new_user" -c "/home/$new_user/arch_linux_setup.sh"
