# We need to set a fixed number of workspaces for this to work.
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/preferences/num-workspaces 10

# Remove the hotkeys already bound to super + num.
#	set hotkeys to false
gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
#	remove mapping
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Super>GRAVE']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Super>GRAVE']"

# Set super + num goes to workspace num.
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['<Super>9']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-10 "['<Super>0']"

# Set super + shift + num moves a window to workspace num.
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1  "['<Super><Shift>1']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2  "['<Super><Shift>2']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3  "['<Super><Shift>3']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4  "['<Super><Shift>4']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5  "['<Super><Shift>5']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6  "['<Super><Shift>6']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7  "['<Super><Shift>7']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8  "['<Super><Shift>8']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9  "['<Super><Shift>9']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-10 "['<Super><Shift>0']"

# Set super + enter to open terminal
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>Return']"  