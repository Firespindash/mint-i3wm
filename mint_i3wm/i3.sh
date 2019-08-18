#!/bin/bash

# This is a automated script of "https://benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/" i3-gaps for ubuntu installation guide

sudo apt install git automake automake1.11 pkgconf libtool libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev libxcb-shape0-dev autoconf i3status -y

dir=~/mint_i3wm

cd /tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

mkdir ~/.i3-gaps_wm
cd ~/.i3-gaps_wm 
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install

if [ ! -d ~/.i3 ]
then
    mkdir ~/.i3
fi

cp $dir/i3 ~/.i3/config
rm -rf ~/.config/i3/
