#!/bin/bash

# Extensions

# Set up the desktop environment
cp ../img/desktop.jpg ~/desktop.jpg
cp ../img/lock.jpg ~/lock.jpg
dconf load /org/gnome/ < ../settings.dconf

# Set up dracula theme for terminal
git clone https://github.com/dracula/gnome-terminal ~/Dropbox/dracular-gnome-terminal
cd ~/Dropbox/dracular-gnome-terminal
./install.sh

# Install dracula theme for gtk
mkdir ~/.themes
wget https://github.com/dracula/gtk/archive/master.zip -O ~/Downloads/dracula.zip
cd ~/Downloads/
unzip dracula.zip
mv ~/Downloads/gtk-master ~/.themes/Dracula
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

# Install dracula icon theme
mkdir ~/.icons
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip -O ~/Downloads/dracula-icons.zip
cd ~/Downloads/
unzip dracula-icons.zip
mv ~/Downloads/Dracula ~/.icons/Dracula
gsettings set org.gnome.desktop.interface icon-theme "Dracula"


# Add startup application
python3 set_startupscript.py 'Dropbox' 'dropbox start'
python3 set_startupscript.py 'ibus' 'ibus-daemon'

# Setup org-protocol
cat > "${HOME}/.local/share/applications/org-protocol.desktop" << EOF
[Desktop Entry]
Name=org-protocol
Exec=emacsclient %u
Type=Application
Terminal=false
Categories=System;
MimeType=x-scheme-handler/org-protocol;
EOF

update-desktop-database ~/.local/share/applications/
