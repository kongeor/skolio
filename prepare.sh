#!/bin/bash

mkdir ~/temp
cd ~/temp/
git clone https://github.com/janet-lang/janet
cd -
cd ~/temp/janet
git checkout v1.8.1
make
sudo make install
cd -
