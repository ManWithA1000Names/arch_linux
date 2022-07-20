#!/bin/bash

cd "$HOME" || exit 1

####################
### Install Rust ###
####################
sudo pacman -S rustup --noconfirm
rustup default stable
####### end ########

####################
### Install Paru ###
####################
git clone https://aur.archlinux.org/paru.git
cd paru || exit 1
if ! makepkg -si --noconfirm; then
	echo "Failed to build Paru!"
	exit 1
fi
cd ..
rm -rf ./paru
paru --gendb
####### end ########

######################
### Update keyring ###
######################
paru --noconfirm -Sy archlinux-keyring
######## end #########

mkdir -p .local/bin
export PATH="$HOME/.local/bin:$PATH"

############################
### Install ALL Packages ###
############################
paru --noconfirm -S <./packages.txt
############ end ###########

##################
### Setup FISH ###
##################
sudo usermod --shell /usr/bin/fish "$USER"
fish -c "set -U fish_greeting"
####### end ########

################################
### Setup Xorg && LightDM ####
################################
# xorg stuff
# echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
# echo "xrandr -s 1920x1080" | sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
# sudo chmod +x /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh

# lightdm stuff
sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
sudo sed -i 's/#user-session=.*/user-session=awesome/' /etc/lightdm/lightdm.conf
echo "xrandr -s 1920x1080" | sudo tee /etc/lightdm/Xsetup
sudo chmod +x /etc/lightdm/Xsetup
sudo sed -i "s/#display-setup-script=.*/display-setup-script=\/etc\/lightdm\/Xsetup/" /etc/lightdm/lightdm.conf
# echo "xrandr --output HDMI-0 --off --output HDMI-1 --off --output HDMI-2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3440x1440 --pos 721x0 --rotate normal --output DP-3 --off --output DP-4 --mode 5120x1440 --pos 0x1440 --rotate normal --output DP-5 --off" |  sudo tee /etc/X11/xinit/xinitrc.d/45custom_xrandr-settings.sh
sudo mkdir -p "/var/lib/AccountsService/users"
echo "[User]" | sudo tee "/var/lib/AccountsService/users/$USER"
echo "Session=" | sudo tee -a "/var/lib/AccountsService/users/$USER"
echo "XSession=awesome" | sudo tee -a "/var/lib/AccountsService/users/$USER"
echo "Icon=/var/lib/AccountsService/icons/avatar.png" | sudo tee -a "/var/lib/AccountsService/users/$USER"
echo "SystemAccount=false" | sudo tee -a "/var/lib/AccountsService/users/$USER"
sudo mv "$HOME/avatar.png" "/var/lib/AccountsService/icons/"
sudo mv "$HOME/background.jpg" "/usr/share/lightdm-webkit/themes/lightdm-webkit-theme-aether/src/img/wallpapers/space-1.jpg"
sudo systemctl enable lightdm
############## end #############

#######################
### NVIDIA Drivers ####
#######################
# nvidia-xconfig
######### end #########

###########################################
### Install/Setup Programming Languages ###
###########################################
yarn global add typescript
go env -w "GOPRIVATE=github.com/ManWithA1000Names/*,git.my.cloud/*"
############### end #################

#########################
### Start mpd service ###
#########################
sudo systemctl --user enable mpd.service
######### end ###########

# my dotfiles
git clone http://git.my.cloud/ManWithA1000Names/.dotfiles.git
cd .dotfiles || exit 1
fish ./deploy.fish
cd ..
# rxhyn dotfiles
git clone --recurse-submodules --depth 1 https://github.com/manwitha1000names/dotfiles-rxhyn.git
if cd dotfiles-rxhyn; then
	git submodule update --remote --merge
	mkdir -p ~/.config/
	mv config/* ~/.config/
	mv misc/home/.config/starship ~/.config/
	mv misc/home/.Xresources ~
	echo "Xcursor.size: 27" >>~/.Xresources
	echo "Xft.dpi: 108" >>~/..Xresources
	mkdir -p ~/.fonts
	mv misc/fonts/* ~/.fonts/
	sudo mv misc/themes/gtk/Aesthetic-Night/* /usr/share/themes/
	mkdir -p ~/.config/gtk-4.0
	mv misc/themes/gtk/Aesthetic-Night-GTK4/* ~/.config/gtk-4.0/
	mkdir -p ~/.config/gtk-3.0
	mkdir -p ~/.themes
	mv misc/themes/kvantum ~/.themes/
	cd ..
	rm -rf dotfiles-rxhyn
fi

#######################
### Desktop Theming ###
#######################
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
rm -rf themes
#######################################################

######################################
### Installing additional Programs ###
######################################
yarn global add webtorrent-cli webtorrent
############### end ##################

#################
### XDG_STUFF ###
#################
xdg-mime default org.pwmt.zathura-pdf-poppler.desktop application/pdf
###### end ######

#####################
### Fish programs ###
#####################
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jethrokuan/z ilancosman/tide"
######## end ########

#################
### edit path ###
#################
fish -c "set -U fish_user_paths $HOME/.local/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/.yarn/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/go/bin \$fish_user_paths"
fish -c "set -U fish_user_paths $HOME/.cargo/bin \$fish_user_paths"
######### end ###########

############
### lvim ###
############
# formatters
yarn global add prettier neovim tree-sitter-cli
go install mvdan.cc/sh/v3/cmd/shfmt@latest
pip install git+https://github.com/psf/black pynvim
cargo install stylua
# linters
pip install flake8 codespell
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
wget https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh
chmod +x ./install.sh
./install.sh --no-install-dependencies --yes
rm ./install.sh
mkdir -p ~/.julia/environments/nvim-lspconfig/
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
### end ###

echo "cleaning up..."
wait
###############
### cleanup ###
###############
rm -f "$HOME/arch_linux_setup.sh"
rm -rf ArchTitus
##### end #####
