#!/bin/sh

[ "$1" ] && flag="$1" || flag='-i'

way=$(pwd)
if [ "$flag" = '-i' ] 2> /dev/null
then

    sudo apt install rofi suckless-tools -y

    [ ! -f ~/.rofirc ] &&
      echo 'export XDG_USER_CONFIG_DIR=~/.config/rofi/config' >> ~/.rofirc

    . ~/.rofirc

    [ ! -d ~/.config/rofi ] && mkdir ~/.config/rofi
    
    echo 'rofi.combi-modi: window,run' >> ~/.config/rofi/config
    echo 'rofi.modi: combi' >> ~/.config/rofi/config
    echo 'rofi.theme: ~/.config/rofi/look-n-feel.rasi' >> ~/.config/rofi/config

    cp -v $way/roficonf ~/.config/rofi/look-n-feel.rasi

elif [ "$flag" = '-u' ] 2> /dev/null
then

    sudo apt remove rofi suckless-tools -y

    [ -f ~/.rofirc ] && rm -v ~/.rofirc

    rm -rfv ~/.config/rofi

else
    echo "${highlight}Invalid flag, please use a valid one (-i or -u).${reset}"
fi
