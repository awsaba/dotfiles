#!/bin/bash

stow vim

# There are some things that always need to cloned first
git clone git@github.com:gmarik/vundle.git vim/.vim/bundle/vundle

# And I end up cloning this to get all the app configs anyway
git clone git@github.com:altercation/solarized.git

