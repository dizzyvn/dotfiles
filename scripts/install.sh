#!/bin/bash
sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

function snap_install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo snap install $1 --classic
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install snapd
install curl
install exfat-utils
install file
install git
install htop
install openvpn
install tmux
install direnv
install pipenv
install openssh-server
install unison
install gdebi
install okular
install chrome-gnome-shell

# Image processing
install gimp
install jpegoptim
install optipng

# Fun stuff
install figlet
install lolcat

# Development
python3-venv
python3-pip
python3-virtualenv

# Fonts
install fonts-firacode

# Texlive
install texlive-full

# Pycharm Professional
snap_install teams-for-linux
snap_install spotify

# VSCode
snap_install code
code --install-extension arrterian.nix-env-selector
code --install-extension bbenoist.Nix
code --install-extension dracula-theme.theme-dracula
code --install-extension evan-buss.font-switcher
code --install-extension KevinRose.vsc-python-indent
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension tuttieee.emacs-mcx
code --install-extension file-icons.file-icons

# Dropbox
which dropbox &> /dev/null
if [ $? -ne 0 ]; then
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
  sudo chmod +x /usr/local/bin/dropbox
fi

# Nix
which nix &> /dev/null
if [ $? -ne 0 ]; then
  curl -L https://nixos.org/nix/install | sh
  /home/dizzy/.nix-profile/etc/profile.d/nix.sh
fi

# Zotero
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
sudo apt update
install zotero
wget https://github.com/jlegewie/zotfile/releases/download/v5.0.16/zotfile-5.0.16-fx.xpi -O ~/Downloads/zotfile.xpi

# Emacs
install emacs
which .emacs.d/bin/doom &> /dev/null
if [ $? -ne 0 ]; then
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
fi

# Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.11.3-amd64.deb -O Downloads/slack.deb
sudo gdebi Downloads/slack.deb
