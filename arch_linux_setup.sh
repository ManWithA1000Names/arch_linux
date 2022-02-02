#!/bin/bash

####################
### Install aura ###
####################
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin || exit 1
makepkg
sudo pacman --noconfirm -U ./*.pkg.*
cd ~ || exit 1
rm -rf aura-bin
######## end #######

####################
### Install FISH ###
####################
sudo aura --noconfirm -Sy fish
chsh -s /usr/bin/fish
fish -c "set -U fish_greeting"
####### end ########

################################
### Install Xorg && LightDM ####
################################
# install
sudo aura --noconfirm -S lightdm xorg lightdm-webkit2-greeter
sudo aura --noconfirm -A lightdm-webkit-theme-aether
# xorg stuff
echo "Xcursor.size: 27" >>.Xresources
echo "Xft.dpi: 108" >>.Xresources
#echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
echo "xrandr -s 1920x1080" | sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
sudo chmod +x /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
# lightdm stuff
sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/#user-session=.*/user-session=awesome/' /etc/lightdm/lightdm.conf
sudo sed -i "s/#display-setup-script=.*/display-setup-script=\/etc\/lightdm\/Xsetup/" /etc/lightdm/lightdm.conf
#echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
echo "xrandr -s 1920x1080" | sudo tee /etc/lightdm/Xsetup
sudo chmod +x /etc/lightdm/Xsetup
sudo cp "$HOME/avatar.png" "/var/lib/AccountsService/icons/"
sudo systemctl enable lightdm
############## end #############

#################
### Bluetooth ###
#################
if ! lsmod | grep btusb; then
	sudo modprobe btusb
fi
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
###### end ######

#######################
### NVIDIA Drivers ####
#######################
#  sudo aura --noconfirm -S nvidia "nvidia-xconfig"
# nvidia-xconfig
sudo aura --noconfirm -S "xf86-video-fbdev"
######### end #########

#####################################
### Install Programming Languages ###
#####################################
sudo aura --noconfirm -S go lua rustup yarn julia python-pip jdk-openjdk
yarn global add typescript
rustup default stable
go env -w "GOPRIVATE=github.com/ManWithA1000Names/*"
############### end #################

#######################################################
### Install Awesome and all the Floppy dependencies ###
#######################################################
# core dependencies
sudo aura --noconfirm -A awesome-git picom-git
# additional dependencies
sudo aura --noconfirm -S inter-font pulseaudio alsa-utils pulseaudio-alsa feh maim xclip imagemagick blueman ffmpeg iproute2 iw thunar papirus-icon-theme lxappearance gpick bluez bluez-utils rofi
# minor desktop changes
# gnome theme
tar -xf ./Kripton.tar.xz
sudo mv ./Kripton /usr/share/themes/
rm -rf ./Kripton.tar.xz
# cursor
tar -zxvf volantes_light_cursors.tar.gz
sudo mv volantes_light_cursors /usr/share/icons
echo "[Icon Theme]" | sudo tee /usr/share/icons/default/index.theme
echo "Inherits=volantes_light_cursors" | sudo tee -a /usr/share/icons/default/index.theme
rm -rf ./volantes_light_cursors.tar.gz
rm -rf ./volantes_light_cursors
#######################################################

############################
### Installing terminals ###
############################
sudo aura --noconfirm -S kitty alacritty
########### end ############

########################
### Installing Utils ###
########################
# rust utils
sudo aura --noconfirm -S exa fd ripgrep
# search / viewing
sudo aura --noconfirm -S bat fzf peco htop openssh man-db neofetch netplan nvtop
# zip utils
sudo aura --noconfirm -S zip unzip
# xdg
sudo aura --noconfirm -S xdg-utils xdg-user-dirs
######## end ###########

########################
### Installing fonts ###
########################
sudo aura --noconfirm -S "noto-fonts" "noto-fonts-emoji"
sudo aura --noconfirm -A "nerd-fonts-fira-code"
######### end ##########

######################################
### Installing additional Programs ###
######################################
sudo aura --noconfirm -S "signal-desktop" pavucontrol zathura vlc zathura-pdf-poppler steam gimp github-cli fuse2
sudo aura --noconfirm -S mpv
sudo aura --noconfirm -A "albert-bin" "popcorntime-bin" "onlyoffice-bin" "stacer"
yarn global add webtorrent-cli
# nextcloud
if [[ ! -d ".local/bin" ]]; then
	mkdir -p .local/bin
fi
# cd .local/bin || exit 1
# link=$(curl https://download.nextcloud.com/desktop/daily/Linux/ | grep -Eo 'Nextcloud-[^"<]+' | tail -n 1)
# curl "https://download.nextcloud.com/desktop/daily/Linux/$link" --output nextcloud
# chmod +x ./nextcloud
# cd ~ || exit 1
############### end ##################

#########################
### Text Editor Setup ###
#########################
# neovim
sudo aura --noconfirm -S neovim
########## end ##########

#################
### XDG_STUFF ###
#################
xdg-mime default org.pwmt.zathura-pdf-poppler.desktop application/pdf
###### end ######

#####################
### Fish programs ###
#####################
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/nvm.fish jethrokuan/z"
######## end ########

#########################
### edit config files ###
#########################
sed -i '$d' .bashrc
fish -c "set -U fish_user_paths $HOME/.local/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/.yarn/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/go/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/.cargo/bin \$fish_user_paths"
######### end ###########

#######################################
### create sudo aura recovery point ###
#######################################
sudo aura -B
################ end ##################

##################
### Set avatar ###
##################
sudo sed -i "s/Icon=.*/Icon=\/var\/lib\/AccountsService\/icons\/avatar.png/" "/var/lib/AccountsService/users/$USER"
##################

####################
### final reboot ###
####################
sudo rm ~/arch_linux_setup.sh
echo ""
echo ""
echo ""
echo "Restarting in 5 seconds"
echo "Remember to run the arch_linux_final.sh when you log in :)"
sleep 5
reboot
###### end ######### TODO: find out how to do bluetooth stuff bluez/bluez-utils/blueman are all installed but it still can't find bluetooth service
