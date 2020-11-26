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

install wordpress
install php
install libapache2-mod-php
install mysql-server
install php-mysql
