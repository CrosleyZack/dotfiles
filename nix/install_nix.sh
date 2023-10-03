#!/bin/bash

# Install nix package manager
sh <(curl -L https://nixos.org/nix/install) --daemon
# Add nixpkgs stable
sudo -i nix-channel --add https://channels.nixos.org/nixos-23.05 nixpkgs
# Install home manager
# sudo -i nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
# sudo -i nix-channel --update