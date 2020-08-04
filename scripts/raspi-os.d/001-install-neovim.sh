#!/bin/bash

sudo -v

sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y

# Get the neovim source code and switch to the stable branch
git clone https://github.com/neovim/neovim && cd neovim && git checkout stable

# Build and install
make -j4 && sudo make install

# Remove source files
cd ..
rm -rf neovim
