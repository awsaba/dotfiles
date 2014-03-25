#!/bin/bash

ln -s ~/.dotfiles/vim/ ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc

# There are some things that always need to cloned first
git clone git@github.com:gmarik/vundle.git ~/.vim/bundle/vundle

# And I end up cloning this to get all the app configs anyway
git clone git@github.com:altercation/solarized.git

