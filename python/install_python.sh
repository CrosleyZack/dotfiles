#!/bin/bash

# Install some apt packages
sudo apt update
sudo apt upgrade
sudo apt install -y \
    python3 \
    python-is-python3

# Update python
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