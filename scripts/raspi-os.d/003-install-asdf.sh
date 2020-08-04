#!/bin/bash

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0-rc1

source . ~/.asdf/asdf.sh

# sudo apt-get install libssl-dev libncurses5-dev build-essential -y

# asdf plugin-add elixir

# asdf plugin-add erlang

asdf plugin-add golang

asdf install

