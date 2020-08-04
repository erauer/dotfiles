#!/bin/bash

mkdir -p $HOME/bin

wget https://github.com/github/hub/releases/download/v2.14.2/hub-linux-arm-2.14.2.tgz

cd /tmp && \
  tar xzf $HOME/hub-linux-arm-2.14.2.tgz && \
  cd /tmp/hub-linux-arm-2.14.2 && \
  sudo ./install

cp /tmp/hub-linux-arm-2.14.2/bin/* $HOME/bin/
rm $HOME/hub-linux-arm-2.14.2.tgz
