#!/bin/bash
#

sudo sh -c 'echo "vscode ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode'

if ! [ -d /etc/apt/keyrings ]; then
	sudo mkdir -p /etc/apt/keyrings
fi

if ! [ -f /etc/apt/keyrings/gierens.gpg ]; then
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg
fi

if ! [ -f /etc/apt/sources.list.d/gierens.list ]; then
	echo 'deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main' | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/sources.list.d/gierens.list
fi

sudo apt update
sudo apt-get -y upgrade
sudo apt-get -y install eza
sudo apt -y autoremove

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz
sudo install lazygit /usr/local/bin
rm lazygit

sudo -H env PATH="${PATH}" npm install -g npm@latest
sudo -H env PATH="${PATH}" npm install -g opencommit

echo "chown takes a few minutes, be patient."
sudo chown -R vscode:vscode /home/vscode/

oco hook set

pre-commit install
