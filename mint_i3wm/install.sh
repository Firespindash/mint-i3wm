#!/bin/bash

if [ $UID -eq 0 ]
then
    echo "Please don't run this program as root user!"
fi

read -p "Just run specific part?[Y/N] " part

dir=~/mint_i3wm
reset=$(tput sgr0)
highlight=$(tput setaf 6)

if [ ! $part == 'Y' ]
then
    
    echo "${highlight}Installing i3-gaps wm${reset}"
    chmod +x $dir/i3.sh
    source $dir/i3.sh

    echo "${highlight}Installing compton compositor forked version${reset}"
    chmod +x $dir/compton.sh
    source $dir/compton.sh

    echo "${highlight}Installing rofi menu${reset}"
    chmod +x $dir/rofi.sh
    source $dir/rofi.sh

    echo "${highlight}Installing extra programs${reset}"
    chmod +x $dir/extra.sh
    source $dir/extra.sh
fi

if [ $XDG_CURRENT_DESKTOP == 'X-Cinnamon' ]
then
    
    git clone https://github.com/jbbr/i3-cinnamon.git

    cd i3-cinnamon/

    sudo make install

    echo "${highlight}Now reboot your machine.${reset}"

fi

if [ $XDG_CURRENT_DESKTOP == 'MATE' ]
then

    cp $dir/mate_i3 ~/.i3/config

    dconf write /org/mate/desktop/session/required-components/windowmanager "'i3'"
    dconf write /org/mate/desktop/background/show-desktop-icons "false"

    git clone https://github.com/city41/mate-i3-applet.git

    cd mate-i3-applet/
    sudo ./setup.py install
    killall mate-panel

    tput setaf 6
    echo 'To add multiple workspaces support, right click in the panel, click on "+Add to panel", search and choose "i3 Workspaces"'

    sleep 1

    echo 'Now to finish the installation, open the "Keyboard Preferences", go to "Layouts", click in "Options" button, click on "Alt/Win key behavior" submenu and change from "Default" to "Hyper is mapped to Win" next to the bottom option.'

    echo "Then reboot your machine."
    tput sgr0
fi

if [ $XDG_CURRENT_DESKTOP == 'XFCE' ]
then

    cp $dir/xfce_i3 ~/.i3/config

    nitrogen /usr/share/backgrounds/linuxmint/default_background.jpg --set-zoom-fill

    sudo apt install xfce4-dev-tools intltool json-glib-tools libjson-glib-dev gtk2.0 gtk-doc-tools libxfce4ui-1-dev xfce4-panel-dev gobject-introspection -y

    git clone https://github.com/denesb/xfce4-i3-workspaces-plugin.git
    
    cd xfce4-i3-workspaces-plugin

    git clone https://github.com/acrisci/i3ipc-glib.git

    cd i3ipc-glib

    sudo ./autogen.sh --prefix=/usr

    sudo make
    sudo make install

    cd ..

    sudo ./autogen.sh --prefix=/usr

    sudo make
    sudo make install

    tput setaf 6
    echo 'Now open "Session and Startup", go to "Session" tab and change "xfwm4" and "xfdesktop" from "Immediately" to "Never", click on "Save Session" and go to "Application Autostart" tab, click on "Add" button and add i3 with the command "i3" then click on "OK" button and click on "Close" button.'
    sleep 2

    echo 'Now open "Keyboard", go to "Application Shortcuts" tab and remove all keyboard shortcuts(you can hold shift to select all of them more quickly), then click on "Close" button.'
    sleep 2

    echo 'Also click on panel, and click on "+Add...", search for "i3", select "i3 Workspaces Plugin" and click on "Add".'
    sleep 2

    echo 'Now reboot your machine.'
    echo 'When you restart your machine go to terminal and type "nitrogen /your/path --set-zoom-fill" to put a background image.'
    tput sgr0

fi

