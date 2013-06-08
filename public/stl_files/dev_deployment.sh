#!/bin/bash
# ==================================================================================================
# AWS Ubuntu 13.04 Development Deployment
#
# This file should be run as root, as the appropriate files will be loaded.
# ==================================================================================================

cd $HOME
# = Directories
mkdir -p downloads
mkdir -p projects
mkdir -p libraries
mkdir -p .vim/colors

# = Git
aptitude -q -y install git

# = GCC
aptitude -q -y install gcc g++ 

# = VIM
aptitude -q -y install vim
git clone git://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
curl -L https://s3.amazonaws.com/robtaylor-development/profiles/.vimrc > $HOME/.vimrc

# = Solarized
git clone git://github.com/altercation/vim-colors-solarized.git $HOME/downloads/vim-colors-solarized
cp downloads/vim-colors-solarized/colors/* $HOME/.vim/colors/

# = Python
aptitude -q -y install python3.3 python3.3-numpy python2.7 python2.7-scipy python2.7-numpy

# = Java
aptitude -q -y install openjdk-7-jdk
