#!/bin/bash

sudo arua -A brave-bin
cat ~/.dotfiles/braveSync | xclip -selection clipboard
echo "Copied sync code"
brave "brave://settings/braveSync"
b_pid="$!"
echo -en "Copy nightTab config? [Y/n]"
read -r choice
if [[ "${choice,,}" == "no" || "${choice,,}" == "n" ]]; then
	exit 0
fi
kill "$b_pid"
cat ~/nightTab.json | xclip -selection clipboard
rm ~/nightTab.json
brave
