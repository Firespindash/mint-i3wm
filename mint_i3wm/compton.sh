#!/bin/sh

[ "$1" ] && flag="$1" || flag='-i'

way=$(pwd)

[ $(which compton) ] && sudo apt remove compton compton-conf -y

compileCompton() {
	git clone https://github.com/tryone144/compton.git && cd compton

	sudo make
	sudo make install
}

if [ "$flag" = '-i' ] 2> /dev/null
then

	sudo apt install libx11-dev libxml2-dev docbook-xsl \
	 libgl1-mesa-dev libxcomposite-dev libxdamage-dev libxfixes-dev \
	 libxext-dev libxrender-dev libxrandr-dev libxinerama-dev pkg-config \
	 make x11proto-core-dev x11-utils libpcre3 libpcre3-dev libconfig-dev \
	 libdrm-dev libgl1-mesa-glx libdbus-1-dev asciidoc -y 

	cd /tmp
	compileCompton
	cd $way

	[ ! -f ~/.config/compton.conf ] && > ~/.config/compton.conf

	cp -v ~/.config/compton.conf ~/.config/compton-conf.bak
	cp -v $way/comptoncfg ~/.config/compton.conf

elif [ "$flag" = '-u' ] 2> /dev/null
then

   cd /tmp
   cd compton/ 2> /dev/null || compileCompton 
   sudo make uninstall
   cd $way

   [ -f ~/.config/compton.conf ] && rm -v ~/.config/compton.conf

   [ -f ~/.config/compton-conf.bak ] &&
    mv -v ~/.config/compton-conf.bak ~/.config/compton.conf

   rm -rfv /tmp/compton
    sudo apt autoremove -y
        
else
	echo "${highlight}Invalid flag, please use a valid one (-i or -u).${reset}"
fi
