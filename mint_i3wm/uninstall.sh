#!/bin/bash

if [ $UID -eq 0 ]
then
	echo "Please don't run this program as root user!"
fi

read -p "Just uninstall specific programs?[Y/N] " specific

dir=~/mint_i3wm
reset=$(tput sgr0)
highlight=$(tput setaf 6)

if [ ! $specific == 'Y' ]
then
	echo "${highlight}Uninstalling i3-gaps wm${reset}"
	chmod +x $dir/i3.sh
	source $dir/i3.sh -u

	echo "${highlight}Uninstalling compton compositor forked version${reset}"
	chmod +x $dir/compton.sh
	source $dir/compton.sh -u

	echo "${highlight}Uninstalling rofi menu${reset}"
	chmod +x $dir/rofi.sh
	source $dir/rofi.sh -u

	echo "${highlight}Uninstalling extra programs${reset}"
	chmod +x $dir/extra.sh
	source $dir/extra.sh -u	
fi

if [ $XDG_CURRENT_DESKTOP == 'X-Cinnamon' ]
then
    if [ -d i3-cinnamon ]
    then
    	rm -rf i3-cinnamon
    fi
    
	git clone https://github.com/jbbr/i3-cinnamon.git

	cd i3-cinnamon/

	sudo make install
	sudo make uninstall
	
    cd ../
	
    rm -rf i3-cinnamon/

	echo "${highlight}Now reboot your machine.${reset}"

fi

if [ $XDG_CURRENT_DESKTOP == 'MATE' ]	
then

	dconf write /org/mate/desktop/session/required-components/windowmanager "'marco'"
	dconf write /org/mate/desktop/background/show-desktop-icons "true"

	tput setaf 6
	echo 'To finish the uninstallation, open the "Keyboard Preferences", go to "Layouts", click in "Options" button, click on "Alt/Win key behavior" submenu and change from "Hyper is mapped to Win" to "Default" on the top option.'

	echo "Then reboot your machine."
	tput sgr0
	
fi

if [ $XDG_CURRENT_DESKTOP == 'XFCE' ]
then

	rm ~/.config/autostart/i3.desktop 2> /dev/null

	tput setaf 6
	echo 'Open "Session and Startup", go to "Saved sessions" tab and click on "Clear saved sessions" button or select the "Default" session and click on "-" button, then click on "Close" button.'
	sleep 2

	echo 'To restore keyboard shortucuts, you can open "Keyboard", go to "Application Shortcuts" tab and add all keyboard shortcuts you want to.'
	sleep 1

	echo 'Now reboot your machine.'
	tput sgr0
	
fi

	
