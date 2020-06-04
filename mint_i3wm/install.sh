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
    source $dir/i3.sh -i

    echo "${highlight}Installing compton compositor forked version${reset}"
    chmod +x $dir/compton.sh
    source $dir/compton.sh -i

    echo "${highlight}Installing rofi menu${reset}"
    chmod +x $dir/rofi.sh
    source $dir/rofi.sh -i

    echo "${highlight}Installing extra programs${reset}"
    chmod +x $dir/extra.sh
    source $dir/extra.sh -i
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

    tput setaf 6

    echo 'Now to finish the installation, open the "Keyboard Preferences", go to "Layouts", click in "Options" button, click on "Alt/Win key behavior" submenu and change from "Default" to "Hyper is mapped to Win" next to the bottom option.'

    echo "Then reboot your machine."
    tput sgr0
    
fi

if [ $XDG_CURRENT_DESKTOP == 'XFCE' ]
then

    cp $dir/xfce_i3 ~/.i3/config

    nitrogen /usr/share/backgrounds/linuxmint/default_background.jpg --set-zoom-fill

    if [ -f ~/.config/autostart/xfdesktop.desktop ]
    then
        cd ~/.config/autostart/
        cp xfdesktop.desktop xfdesktop-desktop.bak
        rm xfdesktop.desktop
    fi
    
    cd ~/
    
    if [ -f ~/.config/autostart/xfwm4.desktop ]
    then
        cd ~/.config/autostart/
        cp xfwm4.desktop xfwm4-desktop.bak
        rm xfwm4.desktop
    fi

    echo '[Desktop Entry]' >> $dir/i3.desktop
    echo 'Encoding=UTF-8' >> $dir/i3.desktop
    echo "Version=$(i3 --version | cut -d ' ' -f 3 | cut -d '-' -f 1)" >> $dir/i3.desktop
    echo 'Type=Application' >> $dir/i3.desktop
    echo 'Name=i3' >> $dir/i3.desktop
    echo 'Comment=' >> $dir/i3.desktop
    echo 'Exec=i3' >> $dir/i3.desktop
    echo 'OnlyShowIn=XFCE;' >> $dir/i3.desktop
    echo 'RunHook=0' >> $dir/i3.desktop
    echo 'StartupNotify=false' >> $dir/i3.desktop
    echo 'Terminal=false' >> $dir/i3.desktop
    echo 'Hidden=false' >> $dir/i3.desktop
    
    sudo chmod +x $dir/i3.desktop
    
    if [ ! -d ~/.config/autostart ]
    then
        mkdir ~/.config/autostart
    fi
    
    mv $dir/i3.desktop ~/.config/autostart/
    
    tput setaf 6
    echo 'Open the "Session and Startup", go to "Session" tab and change "xfwm4" and "xfdesktop" from "Immediately" to "Never", click on "Save session" and click on "Close" button.'
    sleep 2
    
    echo 'Now open "Keyboard", go to "Application Shortcuts" tab and remove all keyboard shortcuts(you can hold shift to select all of them more quickly), then click on "Close" button.'
    sleep 2

    echo 'Now reboot your machine.'
    echo 'When you restart your machine go to terminal and type "nitrogen /your/path --set-zoom-fill" to put a background image.'
    tput sgr0

fi

