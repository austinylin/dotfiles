#!/bin/env bash
set -e
set -u

# function for linking dotfiles
function linkdotfile {
  file="$1"
  if [ ! -e ~/$file -a ! -L ~/$file ]; then
    echo "$file not found, linking..."
    ln -s ~/dotfiles/$file ~/$file
  else
   echo "$file found, ignoring..."
  fi
}

# are we in right directory?
if [ $(basename $(pwd)) != "dotfiles" ]; then
  echo "doesn't look like you're in dotfiles/"
  exit 1
fi


linkdotfile .gitconfig
linkdotfile .gitignore_global
linkdotfile .tmux.conf
linkdotfile .vimrc
linkdotfile .bashrc
linkdotfile .bash_aliases
linkdotfile .gemrc  
