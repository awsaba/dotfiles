#!/bin/bash



# I end up cloning this to get all the app configs anyway
git clone git@github.com:altercation/solarized.git

git clone git@github.com:gmarik/vundle.git vim/.vim/bundle/vundle
stow vim
vim +BundleInstall +qall

