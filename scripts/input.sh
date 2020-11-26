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

# Install input methods
install ibus-mozc
install ibus-unikey

# Install additional language packages
install language-pack-ja
install hunspell-en-au
install language-pack-gnome-ja
install gimp-help-en
install hunspell-en-gb
install hunspell-en-za
install fonts-noto-cjk-extra
install gnome-user-docs-ja
install gnome-getting-started-docs-ja
install firefox-locale-ja
install mozc-utils-gui
install gimp-help-ja
install hunspell-en-ca
