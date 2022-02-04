#!/bin/bash
sudo echo "hello"
git clone http://git.my.cloud/ManWithA1000Names/dear-configs.git -b arch &>/dev/null &
timedatectl set-timezone "Europe/Athens"
lxappearance &>/dev/null &
albert &>/dev/null &
sudo aura --noconfirm -A "brave-bin" &>/dev/null &
# formatters
yarn global add prettier &>/dev/null &
go install mvdan.cc/sh/v3/cmd/shfmt@latest &>/dev/null &
pip install git+https://github.com/psf/black &>/dev/null &
cargo install stylua &>/dev/null &
# linters
pip install flake8 codespell &>/dev/null &
sudo aura --noconfirm -S shellcheck &>/dev/null &
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest &>/dev/null &
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
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
cd dear-configs || exit 0
./deploy.fish
mv ~/avatar.png "$HOME/.config/awesome/configuration/user-profile/$USER.png"
lvim ~/.config/lvim/config.lua
wait
cd ~ && sudo rm -rf ./arch_linux_final.sh
sed -i '$ d' .bashrc
