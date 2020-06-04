#!/bin/bash

# This is a automated script of "https://benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/" i3-gaps for ubuntu installation guide

dir=~/mint_i3wm

if [ $1 == '-i' ] 2> /dev/null
then
	sudo apt install git pkgconf pkg-config automake automake1.11 libtool libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev libxcb-shape0-dev autoconf i3status -y

	cd /tmp
	git clone https://github.com/Airblader/xcb-util-xrm
	cd xcb-util-xrm
	git submodule update --init
	./autogen.sh --prefix=/usr
	make
	sudo make install

	if [ ! -d ~/.i3-gaps_wm ]
	then
		mkdir ~/.i3-gaps_wm
	else
		rm -rf ~/.i3-gpas_wm/i3-gaps
	fi
	
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

elif [ $1 == '-u' ] 2> /dev/null
then
	if [ ! -d /tmp/xcb-util-xrm ]
	then
		cd /tmp
		git clone https://github.com/Airblader/xcb-util-xrm
		cd xcb-util-xrm
		git submodule update --init
		./autogen.sh --prefix=/usr
		make
		sudo make install
	fi

	
	if [ ! -d ~/.i3-gaps_wm ]
	then
		mkdir ~/.i3-gaps_wm
	elif [ -d ~/.i3-gaps_wm/i3-gaps ]
	then
		rm -rf ~/.i3-gaps_wm/i3-gaps
	fi
	
	cd ~/.i3-gaps_wm
	git clone https://www.github.com/Airblader/i3 i3-gaps
	cd i3-gaps
	autoreconf --force --install
	mkdir build
	cd build
	../configure --prefix=/usr --sysconfdir=/etc
	make
	sudo make install
	sudo make uninstall

	sudo rm -rf /tmp/xcb-util-xrm

	if [ -d ~/.i3-gaps_wm ]
	then
		rm -rf  ~/.i3-gaps_wm
	fi
	
	rm -rf ~/.i3

    sudo apt remove i3status -y
	
    sudo apt autoremove -y

else
	echo "${highlight}Don't forget to use a flag (-i or -u).${reset}"
fi
