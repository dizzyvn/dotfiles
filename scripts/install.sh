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

# Image processing
install gimp
install jpegoptim
install optipng

# Fun stuff
install figlet
install lolcat

# Development
python3-venvp
python3-pip

# Dropbox
which dropbox &> /dev/null
if [ $? -ne 0 ]; then
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
  sudo chmod +x /usr/local/bin/dropbox
fi

# Emacs
install emacs
which .emacs.d/bin/doom &> /dev/null
if [ $? -ne 0 ]; then
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
fi

# Nix
which nix &> /dev/null
if [ $? -ne 0 ]; then
  curl -L https://nixos.org/nix/install | sh
  /home/dizzy/.nix-profile/etc/profile.d/nix.sh
fi
#
# Pycharm Professional
snap_install pycharm-professional
snap_install slack
snap_install teams-for-linux
