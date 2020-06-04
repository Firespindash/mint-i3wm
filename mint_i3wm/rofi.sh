#!/bin/bash

dir=~/mint_i3wm

if [ $1 == '-i' ] 2> /dev/null
then

	sudo apt install rofi suckless-tools -y

	if [ ! -f ~/.rofirc ]
	then
    	echo 'export XDG_USER_CONFIG_DIR=~/.config/rofi/config' >> ~/.rofirc
	fi

	source ~/.rofirc

    if [ ! -d ~/.config/rofi ]
    then
        mkdir ~/.config/rofi
    fi
    
	echo 'rofi.combi-modi: window,run' >> ~/.config/rofi/config
	echo 'rofi.modi: combi' >> ~/.config/rofi/config
	echo 'rofi.theme: ~/.config/rofi/look-n-feel.rasi' >> ~/.config/rofi/config

	cp $dir/roficonf ~/.config/rofi/look-n-feel.rasi
	
elif [ $1 == '-u' ] 2> /dev/null
then

	sudo apt remove rofi suckless-tools -y

	if [ -f ~/.rofirc ]
	then
		rm ~/.rofirc
	fi

	rm -rf ~/.config/rofi
else
    echo "${highlight}Don't forget to use a flag (-i or -u).${reset}"
fi
