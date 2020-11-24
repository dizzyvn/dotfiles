#!/bin/bash

# Up from scripts dir
cd ..

function linkDotfile {
  dotfilesDir=$(pwd)
  privatedotfilesDir=/home/dizzy/Dropbox/private_dotfiles

  dest="${2}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ${2}/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

function linkPrivateDotfile {
  dest="${2}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ${2}/${1} ]; then
    # Existing symlink
    echo "Removing existing symlink: ${dest}"
    rm ${dest}

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${privatedotfilesDir}/${1} ${dest}
}

linkDotfile .vimrc ${HOME}
linkDotfile .tmux.conf ${HOME}
linkDotfile .bashrc ${HOME}
linkDotfile .bash_profile ${HOME}
linkDotfile .gitconfig ${HOME}
linkDotfile .gitmessage ${HOME}
linkDotfile .git-completion.bash ${HOME}
linkDotfile .doom.d ${HOME}
linkDotfile .direnvrc ${HOME}
linkPrivateDotfile .ssh ${HOME}

cd vscode
linkDotfile settings.json ${HOME}/.config/Code/User
linkDotfile keybindings.json ${HOME}/.config/Code/User
