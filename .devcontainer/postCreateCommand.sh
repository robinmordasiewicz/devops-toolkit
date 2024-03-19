#!/bin/bash
#

REPODIR=$(pwd)

sudo sh -c 'echo "vscode ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode'

sudo chown -R vscode:vscode /home/vscode/
sudo chown -R vscode:vscode /dc

wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd_1.0.0_"$(dpkg-architecture -q DEB_BUILD_ARCH)".deb -O /tmp/lsd.deb
sudo apt-get install /tmp/lsd.deb
rm -rf /tmp/lsd.deb

if ! [ -d ~/.local/bin ]; then
	mkdir -p ~/.local/bin
fi
if ! [ -d ~/.oh-my-posh/themes/ ]; then
	mkdir -p ~/.oh-my-posh/themes
fi
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin -t ~/.oh-my-posh/themes
oh-my-posh font install Meslo
wget https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/powerlevel10k.omp.json -O ~/.oh-my-posh/themes/powerlevel10k.omp.json
# shellcheck disable=SC2016
echo 'eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/powerlevel10k.omp.json)"' >>~/.zshrc
# shellcheck disable=SC2016
echo 'eval "$(oh-my-posh init bash --config ~/.oh-my-posh/themes/powerlevel10k.omp.json)"' >>~/.bashrc
if ! [ -f ~/.z ]; then
	wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/.z
fi

conda init --all
conda config --set changeps1 False

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

if ! [ -d ~/.vim/pack/plugin/start/vim-terraform ]; then
	git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugin/start/vim-terraform
else
	cd ~/.vim/pack/plugin/start/vim-terraform || return
	git pull
fi

if ! [ -d ~/.vim/pack/themes/start ]; then
	mkdir -p ~/.vim/pack/themes/start
fi

if ! [ -d ~/.vim/pack/themes/start/vim-code-dark ]; then
	git clone https://github.com/tomasiser/vim-code-dark ~/.vim/pack/themes/start/vim-code-dark
else
	cd ~/.vim/pack/themes/start/vim-code-dark || return
	git pull
fi

wget https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.vimrc -O ~/.vimrc

if ! [ -f mkdocs.yml ]; then
	cp .devcontainer/mkdocs.template mkdocs.yml
fi

FIRSTNAMELASTNAME=$(git config --get user.name)
GITHUBREPOSITORYURL=$(git config --get remote.origin.url)
GITHUBREPOSITORYCANONICALURL="${GITHUBREPOSITORYURL%.git}"
GITHUBUSERNAME=$(echo "$GITHUBREPOSITORYURL" | sed 's/.*github.com\/\([^\/]*\)\/.*/\1/')
GITHUBREPOSITORYNAME=$(echo "$GITHUBREPOSITORYURL" | sed 's/.*github.com\/[^\/]*\/\([^\/]*\)\.git/\1/')
GITHUBPAGESURL="https://$GITHUBUSERNAME.github.io/$GITHUBREPOSITORYNAME/"
GITHUBREPOSITORYAPIURL="https://api.github.com/repos/$GITHUBUSERNAME/$GITHUBREPOSITORYNAME"
GITHUBREPOSITORYDESCRIPTION=$(curl -s "$GITHUBREPOSITORYAPIURL" | jq -r '.description')
sed -i "s,GITHUBUSERNAME,${GITHUBUSERNAME},g" "mkdocs.yml"
sed -i "s,FIRSTNAMELASTNAME,${FIRSTNAMELASTNAME},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYNAME,${GITHUBREPOSITORYNAME},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYCANONICALURL,${GITHUBREPOSITORYCANONICALURL},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYDESCRIPTION,${GITHUBREPOSITORYDESCRIPTION},g" "mkdocs.yml"
sed -i "s,GITHUBPAGESURL,${GITHUBPAGESURL},g" "mkdocs.yml"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
ARCH=$(dpkg-architecture -q DEB_BUILD_ARCH)
if [ "${ARCH}" == "amd64" ]; then
	ARCH="32-bit"
fi
wget https://github.com/jesseduffield/lazygit/releases/download/v"${LAZYGIT_VERSION}"/lazygit_"${LAZYGIT_VERSION}"_Linux_"${ARCH}".tar.gz -O lazygit.tar.gz
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz
sudo install lazygit /usr/local/bin
rm lazygit

cd "${REPODIR}" && pre-commit install --allow-missing-config

sudo -H env PATH="${PATH}" npm install -g npm@latest
sudo env PATH="${PATH}" npm install -g opencommit
echo "OCO_AI_PROVIDER=ollama" >~/.opencommit
git config --global --add safe.directory /workspaces/devcontainer
cd "${REPODIR}" && oco hook set

if command -v az &>/dev/null; then
	yes y | az config set auto-upgrade.enable=yes
	yes y | az config set auto-upgrade.prompt=no
fi

sudo apt update
sudo apt-get -y upgrade
sudo apt -y autoremove

yes y | conda update -n base -c conda-forge conda
yes y | conda update --all
yes y | conda update -n base -c conda-forge conda --repodata-fn=repodata.json

# shellcheck disable=SC1091
source /opt/conda/etc/profile.d/conda.sh

cd "${REPODIR}" && conda env create -f ./.devcontainer/mkdocs-environment.yml
