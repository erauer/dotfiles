#!/bin/bash

set -e

sudo -v


git clone --bare https://github.com/erauer/dotfiles.git $HOME/.cfg

git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout

git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFile no

yay -Syu

