#!/bin/sh

[ "$(id -u)" = "0" ] && echo "Please don't run this program as root user!"

read -p "Just run desktop part? [y/n] " part

way=$(pwd)
reset=$(tput sgr0)
highlight=$(tput setaf 6)

if [ ! "$part" = 'y' ]
then
    echo "${highlight}Installing i3-gaps wm${reset}"
    . $way/i3.sh -i

    echo "${highlight}Installing compton compositor forked version${reset}"
    . $way/compton.sh -i

    echo "${highlight}Installing rofi menu${reset}"
    . $way/rofi.sh -i

    echo "${highlight}Installing extra programs${reset}"
    . $way/extra.sh -i
fi

echo "${highlight}Setting desktop specific configurations${reset}"
if [ $XDG_CURRENT_DESKTOP = 'X-Cinnamon' ]
then

    cd /tmp
    [ ! -d /tmp/i3-cinnamon ] && { git clone https://github.com/jbbr/i3-cinnamon.git; \
    cd i3-cinnamon; sudo make install; }
    cd $way

    deadd_latest=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/phuhl/linux_notification_center/releases/latest | cut -d '/' -f 8)
    curl -Ls https://github.com/phuhl/linux_notification_center/releases/download/${deadd_latest}/deadd-notification-center -o deadd-notification-center
    chmod +x deadd-notification-center && sudo mv -v deadd-notification-center /usr/local/bin/

    [ ! -d ~/.config/deadd ] && mkdir -v ~/.config/deadd ||
      cp -rv ~/.config/deadd ~/.config/deadd.bak

    cp -v $way/deadd.conf ~/.config/deadd/

    echo "${highlight}When you log out, a ball will appear close to the input, click there and change to 'Cinnamon + i3'.${reset}"

fi

if [ $XDG_CURRENT_DESKTOP = 'MATE' ]
then

    cp -v $way/mate_i3 ~/.i3/config

    dconf write /org/mate/desktop/session/required-components/windowmanager "'i3'"
    dconf write /org/mate/desktop/background/show-desktop-icons "false"

    dconf load /org/mate/desktop/peripherals/keyboard/kbd/ < $way/mate-keyboard
    dconf load /org/mate/panel/ < $way/mate-panel

    cd /tmp
    [ ! -d /tmp/mate-i3-applet ] && git clone https://github.com/city41/mate-i3-applet.git
    cd mate-i3-applet/
    sudo ./setup.py install
    killall mate-panel
    cd $way

fi

if [ $XDG_CURRENT_DESKTOP = 'XFCE' ]
then

    sudo apt install xfce4-dev-tools json-glib-tools libjson-glib-dev libgtk2.0-dev gtk-doc-tools \
     libxfce4ui-2-dev gobject-introspection libxfce4panel-2.0-dev -y

    cd /tmp
    git clone https://github.com/acrisci/i3ipc-glib.git
    cd i3ipc-glib
    sudo ./autogen.sh --prefix=/usr
    sudo make
    sudo make install
    cd ..
    git clone https://github.com/denesb/xfce4-i3-workspaces-plugin.git
    cd xfce4-i3-workspaces-plugin
    sudo ./autogen.sh --prefix=/usr
    sudo make
    sudo make install
    cd $way

    cp -v $way/xfce_i3 ~/.i3/config

    dir=~/.config/autostart

    if [ -f ~/.config/autostart/xfdesktop.desktop ]
    then
        cp -v $dir/xfdesktop.desktop $dir/xfdesktop-desktop.bak
        rm -v $dir/xfdesktop.desktop
    fi
    
    if [ -f ~/.config/autostart/xfwm4.desktop ]
    then
        cp -v $dir/xfwm4.desktop $dir/xfwm4-desktop.bak
        rm -v $dir/xfwm4.desktop
    fi

    echo '[Desktop Entry]' >> i3.desktop
    echo 'Encoding=UTF-8' >> i3.desktop
    echo "Version=$(i3 --version | cut -d ' ' -f 3 | cut -d '-' -f 1)" >> i3.desktop
    echo 'Type=Application' >> i3.desktop
    echo 'Name=i3' >> i3.desktop
    echo 'Comment=' >> i3.desktop
    echo 'Exec=i3' >> i3.desktop
    echo 'OnlyShowIn=XFCE;' >> i3.desktop
    echo 'RunHook=0' >> i3.desktop
    echo 'StartupNotify=false' >> i3.desktop
    echo 'Terminal=false' >> i3.desktop
    echo 'Hidden=false' >> i3.desktop
    
    sudo chmod +x i3.desktop
    
    [ ! -d ~/.config/autostart ] && mkdir ~/.config/autostart
        
    mv -v i3.desktop ~/.config/autostart/

    killall xfconfd
    
    xfconf-query -c xfce4-session -p /sessions/Failsafe/Client0_Command -t string -sa xfsettingsd
    xfconf-query -c xfce4-session -p /sessions/Failsafe/Client1_Command -t string -sa i3
    sudo rm -v /usr/bin/xfdesktop
        
    [ -f ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ] &&
      cp -v ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.bak

    cp -v $way/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

    killall xfdesktop && nitrogen /usr/share/backgrounds/linuxmint/ktee_linuxmint.png --set-zoom-fill --save
    xfconf-query -c xfce4-panel -p /plugins/plugin-9 -t string -s i3-workspaces
    xfce4-panel -r

fi

echo "${highlight}Now log out and log in again.${reset}"
