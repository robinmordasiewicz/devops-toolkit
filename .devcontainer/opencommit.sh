#!/bin/bash
#

REPODIR=$(pwd)

echo "Enter the Host IP address:"
read -r HOSTIPADDRESS

if sed -i "s/HOSTIPADDRESS/${HOSTIPADDRESS}/g" "${REPODIR}"/.devcontainer/opencommit-ollama.patch; then
	if [ -d /tmp/opencommit ]; then
		rm -rf /tmp/opencommit
	fi
	git clone https://github.com/di-sukharev/opencommit.git /tmp/opencommit
	cd /tmp/opencommit || return
	git apply "${REPODIR}"/.devcontainer/opencommit-ollama.patch
	sudo -H env PATH="${PATH}" npm uninstall -g
	sudo -H env PATH="${PATH}" npm install -g
	echo "OCO_AI_PROVIDER=ollama" >~/.opencommit
	cd "${REPODIR}" || return
	oco hook set
fi
