#!/bin/bash

# Enable fractional scaling
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
# gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
# gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state false
# gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
