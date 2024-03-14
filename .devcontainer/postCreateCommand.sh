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
sudo -H env PATH="${PATH}" oco hook set

echo "chown takes a few minutes, be patient."
sudo chown -R vscode:vscode /home/vscode/
sudo chown -R vscode:vscode /dc

pre-commit install

az config set auto-upgrade.enable=yes
wget https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -O ~/.oh-my-zsh/custom/az.zsh

if ! [ -d ~/.vim/pack/plugin/start ]; then
	mkdir -p ~/.vim/pack/plugin/start
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-airline ]; then
	git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugin/start/vim-airline
else
	cd ~/.vim/pack/plugin/start/vim-airline || return
	git pull
fi

cp .devcontainer/.vimrc ~/
