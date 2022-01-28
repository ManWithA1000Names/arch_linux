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
sudo aura --noconfirm -S lightdm xorg lightdm-webkit2-greeter
sudo aura --noconfirm -A lightdm-webkit-theme-aether
echo "Xcursor.size: 27" >>.Xresources
echo "Xft.dpi: 108" >>.Xresources
#echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
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
sudo aura --noconfirm -S go lua rustup yarn julia python-pip
yarn global add typescript
rustup default stable
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
sudo aura --noconfirm -S "signal-desktop" "github-cli" pavucontrol zathura mpv vlc zathura-pdf-poppler steam fuse2 gimp
sudo aura --noconfirm -A "albert-bin" "popcorntime-bin"
yarn global add webtorrent-cli
# nextcloud
if [[ ! -d ".local/bin" ]]; then
	mkdir -p .local/bin
fi
cd .local/bin || exit 1
link=$(curl https://download.nextcloud.com/desktop/daily/Linux/ | grep -Eo 'Nextcloud-[^"<]+' | tail -n 1)
curl "https://download.nextcloud.com/desktop/daily/Linux/$link" --output nextcloud
chmod +x ./nextcloud
cd ~ || exit 1
############### end ##################

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
echo "PATH=$HOME/.local/bin:\$PATH" >>.bashrc
echo "PATH=$HOME/.yarn/bin:\$PATH" >>.bashrc
fish -c "set -U fish_user_paths $HOME/.local/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/.yarn/bin \$fish_user_paths"
######### end ###########

#######################################
### create sudo aura recovery point ###
#######################################
sudo aura -B
################ end ##################

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
