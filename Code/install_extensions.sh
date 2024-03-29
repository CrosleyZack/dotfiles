#!/bin/bash

code --install-extension golang.go
code --install-extension asvetliakov.vscode-neovim
# Required link for nvim to work
sudo ln -s $(which nvim) /usr/local/bin/nvim
code --install-extension GitHub.copilot
code --install-extension ms-python.python
code --install-extension zxh404.vscode-proto3
code --install-extension ms-azuretools.vscode-docker
