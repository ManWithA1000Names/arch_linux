#!/bin/bash
cd ~ || exit 1
sudo aura --noconfirm -A "brave-bin"
gh auth login
gh repo clone dear-configs
gh config set -h github.com git_protocol https
timedatectl set-timezone "Europe/Athens"
fish -c "fisher install ilancosman/tide"
albert &>/dev/null &
lxappearance &>/dev/null &
~/install_photo_gimp.sh &>/dev/null &
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
lvim ~/.config/lvim/config.lua
cd dear-configs || exit 0
./deploy.fish
wait
awesome-client "awesome.restart()"
cd ~ && sudo rm -rf ./arch_linux_final.sh
killall kitty
