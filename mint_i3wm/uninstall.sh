#!/bin/sh

[ "$(id -u)" = "0" ] && echo "Please don't run this program as root user!"

read -p "Just uninstall desktop configs? [y/n] " specific

way=$(pwd)
reset=$(tput sgr0)
highlight=$(tput setaf 6)
message="Now reboot your machine."

if [ ! "$specific" = 'y' ]
then
	echo "${highlight}Uninstalling i3-gaps wm${reset}"
	. $way/i3.sh -u

	echo "${highlight}Uninstalling compton compositor forked version${reset}"
	. $way/compton.sh -u

	echo "${highlight}Uninstalling rofi menu${reset}"
	. $way/rofi.sh -u

	echo "${highlight}Uninstalling extra programs${reset}"
	. $way/extra.sh -u	
fi

echo "${highlight}Unsetting desktop specific configurations${reset}"
if [ $XDG_CURRENT_DESKTOP = 'X-Cinnamon' ]
then

	sudo rm -v /usr/bin/i3*

	rm -rfv ~/.config/deadd

	[ -d ~/.config/deadd.bak ] && mv -v ~/.config/deadd.bak ~/.config/deadd 

	sudo rm -v /usr/local/bin/deadd-notification-center

	
fi

if [ $XDG_CURRENT_DESKTOP = 'MATE' ]	
then

	dconf write /org/mate/desktop/session/required-components/windowmanager "'marco'"
	dconf write /org/mate/desktop/background/show-desktop-icons "true"

	resetKeys="$(sed "s/, 'altwin.*//;s/options=//" mate-keyboard | awk 'NR==2')]"

	dconf write /org/mate/desktop/peripherals/keyboard/kbd/options "$resetKeys"

    mate-panel --reset

	sudo rm -rfv /usr/lib/mate-i3-applet /usr/share/dbus-1/services/matei3applet.service
	sudo rm -v /usr/share/mate-panel/applets/matei3applet.mate-panel-applet /usr/local/lib/python3.8/dist-packages/mate_i3_applet-*

	notify-send "mint-i3wm" "$message" --expire-time=7000 --icon=utilities-terminal
	
fi

if [ $XDG_CURRENT_DESKTOP = 'XFCE' ]
then

	rm -v ~/.config/autostart/i3.desktop 2> /dev/null

	cd /tmp/i3ipc-glib || cd /tmp && { \
	 git clone https://github.com/acrisci/i3ipc-glib.git; \
	 cd i3ipc-glib; sudo ./autogen.sh --prefix=/usr; sudo make; \ 
	 sudo make install; }
    cd ..
	cd /tmp/xfce4-i3-workspaces-plugin || { \
	 git clone https://github.com/denesb/xfce4-i3-workspaces-plugin.git; \
	 cd xfce4-i3-workspaces-plugin; sudo ./autogen.sh --prefix=/usr; \
	 sudo make; sudo make install; }
	sudo make uninstall
	cd ..
	cd i3ipc-glib && sudo make uninstall
	sudo rm -rfv /tmp/{i3pc-glib,xfce4-i3-workspaces-plugin}
	cd $way

	killall xfconfd

	cp -v ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.bak ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

	sudo apt reinstall xfdesktop4 -y

	xfconf-query -c xfce4-session -p /sessions/Failsafe -r
	xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -t string -sa 'xfwm4'
	xfconf-query -c xfce4-panel -p /plugins/plugin-9 -t string -s ''
	xfce4-panel -r
	
fi

echo "${highlight}$message${reset}"
