#!/bin/bash

sudo arua -A brave-bin
xclip -selection clipboard <~/.dotfiles/braveSync
echo "Copied sync code"
brave "brave://settings/braveSync"
b_pid="$!"
echo -en "Copy nightTab config? [Y/n]"
read -r choice
if [[ "${choice,,}" == "no" || "${choice,,}" == "n" ]]; then
	exit 0
fi
kill "$b_pid"
xclip -selection clipboard <~/nightTab.json
rm ~/nightTab.json
brave
