#!/bin/bash

sudo -v

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get install zsh git -y

sudo chsh --shell /bin/zsh $USER

git clone --bare https://github.com/erauer/dotfiles.git $HOME/.cfg

git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout

git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFile no





