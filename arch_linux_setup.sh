#!/bin/bash

####################
### Install aura ###
####################
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin || exit 1
makepkg
sudo pacman -U ./*.pkg.*
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
sudo aura --noconfirm -S lightdm xorg lightdm-webkit2-greeter
sudo aura --noconfirm -A lightdm-webkit-theme-aether
echo "Xcursor.size: 27" >>.Xresources
echo "Xft.dpi: 108" >>.Xresources
#echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
echo "xrandr -s 1920x1080" | sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
sudo chmod +x /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/#user-session=.*/user-session=awesome/' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm
############## end #############

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
sudo aura --noconfirm -S go lua rustup yarn julia
yarn global add typescript
rustup default stable
############### end #################

#######################################################
### Install Awesome and all the Floppy dependencies ###
#######################################################
# core dependencies
sudo aura --noconfirm -A awesome-git picom-git #FIX: for some reason rofi-git fails to rosolve all dependencies
# additional dependencies
sudo aura --noconfirm -S inter-font pulseaudio alsa-utils pulseaudio-alsa feh maim xclip imagemagic blueman ffmpeg iproute2 iw thunar papirus-icon-theme
# minor desktop changes
# gnome theme
curl --output Kripton.tar.xz https://dl2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTY0MjM3Mjc4NSwidSI6bnVsbCwibHQiOiJkb3dubG9hZCIsInMiOiI3ZmU5NzhlNDc2YTBjYTZhZGE2N2E0NDI2ZGIyNDBmYjI5MTU0YjMxMzYzOGRhZTY2OGFhYWY0YjcxMDVkODZkYjZlYjgzY2YxODkxZDYwYmYyOTNjYWUyMzE5YjQzMGQyMGJmZGQ4ZTQxMzQyNGRlNmM1MGI2ZTBkNDkzYmYxNiIsInQiOjE2NDMyMDk5OTksInN0ZnAiOiJkYzMwOTA2ZmUwYTBiYTljNzYwODY3MjUwNTZlZTA0YSIsInN0aXAiOiIxMDkuMjQyLjIyNy4zMyJ9.biAd6dRZKl0aPzT7_syU_2mwviXz1UZYWivDxxud_oQ/Kripton.tar.xz
tar -xf ./Kripton.tar.xz
sudo mv ./Kripton /usr/share/themes/
rm -rf ./Kripton.tar.xz
# cursor
curl --output volantes_light_cursors.tar.gz https://dl1.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTU4MTIzMTM3MywidSI6bnVsbCwibHQiOiJkb3dubG9hZCIsInMiOiI4MTcxNzNkMjhmODBlYmU3YzNhZmEzZDEzM2JmZDljYjA1ODdkY2JhMjMxMmUyYTMyNTVhYzYyNzAyM2E3YzQ4YjE2ZjdlNTMxYmRhNGJkMzMxZjEyNWQzNDI3ODc5Mzg4NmZhODI3MTE2NTEyZTU4YTk3NTkxNjVjZjE2NzFlYiIsInQiOjE2NDMyMTM5MzIsInN0ZnAiOiJkYzMwOTA2ZmUwYTBiYTljNzYwODY3MjUwNTZlZTA0YSIsInN0aXAiOiIxMDkuMjQyLjIyNy4zMyJ9.0EagILZtheUNI0Q04V3g88TVuEExcJHcFfX1ChoiIow/volantes_light_cursors.tar.gz
sudo tar -zxvf volantes_light_cursors.tar.gz -C "/usr/share/icons/"
echo "[Icon Theme]" | tee /usr/share/icons/default/index.theme
echo "Inherits=volantes_light_cursors" | tee -a /usr/share/icons/default/index.theme
rm -rf ./volantes_light_cursors.tar.gz
# gtk theme
mkdir .config/gtk-2.0 .config/gtk-3.0 .config/gtk-4.0
{
	echo "[Settings]"
	echo "gtk-theme-name=Kripton"
	echo "gtk-icon-them-name=Papirus"
	echo "gtk-font-name=Cantarell 11"
	echo "gtk-cursor-theme-name=volantes_light_cursors"
	echo "gtk-cursor-theme-size=0"
	echo "gtk-toolbar-style=GTK_TOOLBAR_BOTH"
	echo "gtk-GTK_ICON_SIZE_LARGE_TOOLBAR"
	echo "gtk-button-images=1"
	echo "gtk-menu-images=1"
	echo "gtk-enable-event-sounds=1"
	echo "gtk-enable-input-feedback-sounds=1"
	echo "gtk-xft-antialias=1"
	echo "gtk-xft-hinting=1"
	echo "gtk-xft-hintstyle=hintfull"
} >".config/gtk-2.0/settings.ini"
cp .config/gtk-2.0/setting.ini .config/gtk-3.0/settings.ini
cp .config/gtk-2.0/setting.ini .config/gtk-4.0/settings.ini
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
sudo aura --noconfirm -S "signal-desktop" "github-cli" pavucontrol zathura mpv vlc zathura-pdf-poppler steam
sudo aura --noconfirm -A "albert-bin" "brave-bin" "popcorntime-bin" #FIX: brave-bin failed to install
yarn global add webtorrent-cli
# nextcloud
if [[ ! -d ".local/bin" ]]; then
	mkdir -p .local/bin
fi
cd .local/bin || exit 1
curl 'https://objects.githubusercontent.com/github-production-release-asset-2e65be/105010691/8cc26b57-ba5c-437e-9b24-731f365a2065?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20220126%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220126T164621Z&X-Amz-Expires=300&X-Amz-Signature=b932142054a5ee23825072b997d0d036e2f99e9d1fb673812cde56c6f51342b3&X-Amz-SignedHeaders=host&actor_id=70207966&key_id=0&repo_id=105010691&response-content-disposition=attachment%3B%20filename%3DNextcloud-3.4.1-x86_64.AppImage&response-content-type=application%2Foctet-stream' --output nextcloud
chmod +x ./nextcloud
cd ~ || exit 1
############### end ##################

#################
### PhotoGIMP ###
#################
sudo aura -S "gimp"
curl https://codeload.github.com/Diolinux/PhotoGIMP/tar.gz/refs/tags/1.0 --output PhotoGIMP.tar.gz
tar -xf ./PhotoGIMP.tar.gz
rm ./PhotoGIMP.tar.gz
mkdir ./.icons
mkdir -p .local/share/applications/
if cd PhotoGIMP-1.0; then
	cp .icons/* ../.icons/
	cp .local/share/applications/* ../.local/share/applications
	sed -i 's/Comment=.*/Comment=GNU Image Manipulation Program' ~/.local/share/applications/org.gimp.GIMP.desktop
	sed -i 's/GenericName=.*/GenericName=Image Editor/' ~/.local/share/applications/org.gimp.GIMP.desktop
	sed -i 's/Exec=.*/Exec=gimp/' ~/.local/share/applications/org.gimp.GIMP.desktop
	rm -rf ~/.config/GIMP/*
	cp -R .var/app/org.gimp.GIMP/config/GIMP/2.10 ../.config/GIMP
	cd ..
	rm -rf PhotoGIMP-1.0
else
	rm -rf PhotoGIMP-1.0
fi
#################

#########################
### Text Editor Setup ###
#########################
# neovim
sudo aura --noconfirm -S neovim
# lvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
# formatters
yarn global add prettier
go install mvdan.cc/sh/v3/cmd/shfmt@latest
pip install git+https://github.com/psf/black
cargo install stylua
# linters
pip install flake8 codespell
sudo aura --noconfirm -S shellcheck
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.43.0@latest
# julia language server
mkdir -p ~/.julia/environments
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
mkdir -p ~/.config/lvim/ftplugin
touch ~/.config/lvim/ftplugin/julia.lua
{
	echo "local opts = {}"
	echo 'opts = require("lvim.lsp").get_common_opts()'
	echo 'require("lspconfig").julials.setup(opts)'
} >~/.config/lvim/ftplugin/julia.lua
########## end ##########

#################
### XDG_STUFF ###
#################
xdg-mime default org.pwmt.zathura-pdf-poppler.desktop
###### end ######

#####################
### Fish programs ###
#####################
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jorgebucaran/nvm.fish jethrokuan/z"
######## end ########

#####################################
### removed auto-exec from bashrc ###
#####################################
sed -i '$d' .bashrc
################ end ################

##################################
### create sudo aura recovery point ###
##################################
sudo aura -B
############# end ################

####################
### final reboot ###
####################
rm ~/arch_linux_setup.sh
ehco ""
ehco ""
ehco ""
echo -n "Reboot now to finalize system? [Y/n]"
read -r reboot_now
if [[ "$reboot_now" == "n" || "$reboot_now" == "N" || "$reboot_now" == "no" || "$reboot_now" == "NO" || "$reboot_now" == "No" || "$reboot_now" == "nO" ]]; then
	exit 0
else
	reboot
fi
###### end #########
