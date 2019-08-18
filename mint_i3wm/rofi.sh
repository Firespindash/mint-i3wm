#!/bin/bash

sudo apt install rofi suckless-tools -y

dir=~/mint_i3wm

if [ ! -f ~/.rofirc ]
then
    echo 'export XDG_USER_CONFIG_DIR=~/.config/rofi/config' >> ~/.rofirc
fi

source ~/.rofirc

mkdir ~/.config/rofi

echo 'rofi.combi-modi: window,run' >> ~/.config/rofi/config
echo 'rofi.modi: combi' >> ~/.config/rofi/config
echo 'rofi.theme: ~/.config/rofi/look-n-feel.rasi' >> ~/.config/rofi/config

cp $dir/roficonf ~/.config/rofi/look-n-feel.rasi
