#!/bin/bash

if [ compton ]
then
    sudo apt remove compton compton-conf -y
fi

if [ xsltproc ]
then
    sudo apt remove xsltproc -y
fi

dir=~/mint_i3wm/

if [ $1 == '-i' ] 2> /dev/null
then

	sudo apt install libx11-dev xsltproc libxml2-dev docbook-xsl libgl1-mesa-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxext-dev libxrender-dev libxrandr-dev libxinerama-dev pkg-config make x11proto-core-dev x11-utils libpcre3 libpcre3-dev libconfig-dev libdrm-dev libgl1-mesa-glx libdbus-1-dev asciidoc -y 

	git clone https://github.com/tryone144/compton.git && cd $dir/compton

	sudo make
	sudo make install

	if [ ! -f ~/.config/compton.conf ]
	then
    	>> ~/.config/compton.conf
	fi

	cp ~/.config/compton.conf ~/.config/compton-conf.bak
	cp $dir/comptoncfg ~/.config/compton.conf

elif [ $1 == '-u' ] 2> /dev/null
then

    if [ ! xlstproc ]
    then
        sudo apt install xlstproc libxml2-dev docbook-xsl -y
    fi
	
	git clone https://github.com/tryone144/compton.git && cd $dir/compton

	sudo make
	sudo make install
	sudo make uninstall

	if [ -f ~/.config/compton.conf ]
	then
		rm ~/.config/compton.conf
	fi

    if [ -f ~/.config/compton-conf.bak ]
    then
        mv ~/.config/compton-conf.bak ~/.config/compton.conf
    fi
    
    sudo apt autoremove -y
        
else
	echo "${highlight}Don't forget to use a flag (-i or -u).${reset}"
fi
