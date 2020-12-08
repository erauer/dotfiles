#!/bin/bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0-rc1

yes | yay -S unzip

source $HOME/.asdf/asdf.sh

asdf plugin-add golang

asdf install

