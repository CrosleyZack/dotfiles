#!/bin/bash
# $1 assumed to be pull location of dotfiles repo.
CONFIG=$HOME/.config

# Ensure dotfiles repo is defined
if [ -z "$1" ]
then
      echo "\$1 must be dotfiles directory"
      exit 1
fi

# symbolic link:
#  ln -s target-path link-path

# Alacritty
mkdir -p $CONFIG/alacritty
rm -f $CONFIG/alacritty/alacritty.yml
echo "Linking $CONFIG/alacritty/alacritty.yml to $1/alacritty/alacritty.yml"
ln -s $1/alacritty/alacritty.yml $CONFIG/alacritty/alacritty.yml

# VS Code
mkdir -p $CONFIG/Code/User
rm $CONFIG/Code/User/keybindings.json
echo "Linking $CONFIG/Code/User/keybindings.json to $1/Code/User/keybindings.json"
ln -s $1/Code/User/keybindings.json $CONFIG/Code/User/keybindings.json
rm $CONFIG/Code/User/settings.json
echo "Linking $CONFIG/Code/User/settings.json to $1/Code/User/settings.json"
ln -s $1/Code/User/settings.json $CONFIG/Code/User/settings.json

# Tmux
mkdir -p $CONFIG/tmux
rm $CONFIG/tmux/tmux.conf
echo "Linking $CONFIG/tmux/tmux.conf to $1/tmux/tmux.conf"
ln -s $1/tmux/tmux.conf $CONFIG/tmux/tmux.conf

#Zsh
rm $HOME/.zshrc
echo "Linking $HOME/.zshrc to $1/zsh/zshrc"
ln -s $1/zsh/zshrc $HOME/.zshrc

# Docker
sudo rm /etc/docker/daemon.json
echo "Linking /etc/docker/deamon.json to $1/docker/daemon.json"
sudo ln -s $1/docker/daemon.json /etc/docker/daemon.json

# Tmux
mkdir -p $CONFIG/tmux
rm $CONFIG/tmux/tmux.conf
echo "Linking $HOME/.ghc/ghci.conf to $1/haskell/ghci.conf"
ln -s $1/haskell/ghci.conf $HOME/.ghc/ghci.conf
chmod go-w $HOME/.ghc
chmod go-w $1/haskell/ghci.conf

# Proxychains
mkdir -p $HOME/.proxychains/
rm $HOME/.proxychains/proxychains.conf
echo "Linking $HOME/.proxychains/proxychains.conf to $1/proxychains/proxychains.conf"
ln -s $1/proxychains/proxychains.conf $HOME/.proxychains/proxychains.conf

# PulseAudio
mkdir -p $HOME/.config/pulse/
rm $HOME/.config/pulse/default.pa
echo "Linking $HOME/.config/pulse/default.pa to $1/pulse/default.pa"
ln -s $1/pulse/default.pa $HOME/.config/pulse/default.pa

# Gitconfig - We actually copy this one so that we can change the user name!
rm $HOME/.gitconfig
echo "copying $1/git/.gitconfig to $HOME/.gitconfig"
cp $1/git/.gitconfig $HOME/.gitconfig

# Vim
rm $HOME/.vimrc
echo "Linking $HOME/.vimrc to $1/vim/.vimrc"
ln -s $1/vim/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim
rm -rf $HOME/.vim/colors
echo "Linking $HOME/.vim/colors to $1/vim/colors"
ln -s $1/vim/colors $HOME/.vim/colors
