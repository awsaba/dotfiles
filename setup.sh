#!/bin/bash

# Check if git and stow are installed

command -v stow >/dev/null 2>&1 || { echo >&2 "stow is not installed"; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 "git is not installed"; exit 1; }

# I end up cloning this to get all the app configs anyway
git clone git@github.com:altercation/solarized.git

git clone git@github.com:gmarik/vundle.git vim/.vim/bundle/vundle
stow vim
vim +PluginInstall +qall

