#!/bin/bash

sudo apt update
sudo apt upgrade
sudo apt install -y \
    python3 \
    python-is-python3 \
    pipenv \
    python3.10-venv \
    python3-pip

python -m pip install --upgrade pip wheel setuptools virtualenv

source "${BASH_SOURCE%/*}/../tools/install_tools.sh"

# Setup pyenv
is_installed pyenv
if [ "false" = "$INSTALLED" ]
then
	git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PATH:$PYENV_ROOT/bin"
	# NOTE make sure to regularly `git pull` to update.
	# Install pyenv-virtualenv
	git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi

# Setup poetry
is_installed poetry
if [ "false" = "$INSTALLED" ]
then
    curl -sSL https://install.python-poetry.org | python3 -
fi


# Setup google cloud CLI. See https://cloud.google.com/sdk/docs/install
is_installed google-cloud-cli
if [ "false" = "$INSTALLED" ]
then
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update
	sudo apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
else
	echo "google-cloud-cli already installed! Skipping..."
fi

# Install spanner-cli. See https://github.com/cloudspannerecosystem/spanner-cli#install
is_installed spanner-cli
if [ "false" = "$INSTALLED" ]
then
	go install github.com/cloudspannerecosystem/spanner-cli@latest
fi

# Install yubikey agent.
is_installed yubikey-agent
if [ "false" = "$INSTALLED" ]
then
	mkdir ~/temp
	cd ~/temp
	git clone https://filippo.io/yubikey-agent && cd yubikey-agent
	go build && sudo cp yubikey-agent /usr/local/bin/
	yubikey-agent -setup
	curl https://raw.githubusercontent.com/FiloSottile/yubikey-agent/main/contrib/systemd/user/yubikey-agent.service > ~/.config/systemd/user/yubikey-agent.service
	systemctl daemon-reload --user
	sudo systemctl enable --now pcscd.socket
	systemctl --user enable --now yubikey-agent
	export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/yubikey-agent/yubikey-agent.sock"
else
	echo "yubikey-agent already installed! Skipping"
fi


# Install alacritty. See https://github.com/alacritty/alacritty/blob/master/INSTALL.md
is_installed alacritty
if [ "false" = "$INSTALLED" ]
then
        rm -rf ~/temp/alacritty
        mkdir ~/temp/alacritty
        cd ~/temp/alacritty
        git clone https://github.com/alacritty/alacritty.git
        cd alacritty
        #       Install requirements
        sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
        cargo build --release
        #       Move to bin
        sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
        sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
        # We shouldn't need this line, but execute it if not the default for some reason.
        # sudo update-alternatives --config x-terminal-emulator
else
        echo "alacritty already installed! Skipping..."
fi

