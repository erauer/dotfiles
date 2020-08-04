#!/bin/bash

sudo -v

sudo apt-get install curl wget -y

wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_armhf.deb

sudo dpkg -i bat_0.15.4_armhf.deb

rm bat_0.15.4_armhf.deb
