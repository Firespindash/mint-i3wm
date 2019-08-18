#!/bin/bash

if [ compton ]
then
    sudo apt remove compton compton* -y
fi

if [ xsltproc ]
then
    sudo apt remove xsltproc -y
fi

dir=~/mint_i3wm

if [ ! -d $dir/compton ]
then
    mkdir $dir/compton
fi

cd $dir/compton

sudo apt install libx11-dev xsltproc libgl1-mesa-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxext-dev libxrender-dev libxrandr-dev libxinerama-dev pkg-config make x11proto-core-dev x11-utils libpcre3 libpcre3-dev libconfig-dev libdrm-dev libgl1-mesa-glx libdbus-1-dev asciidoc -y 

git clone https://github.com/tryone144/compton.git && cd $dir/compton/compton

sudo make
sudo make install

if [ ! -f ~/.config/compton.conf ]
then
    >> ~/.config/compton.conf
fi

cp ~/.config/compton.conf ~/.config/compton-conf.bak
cp $dir/comptoncfg ~/.config/compton.conf
