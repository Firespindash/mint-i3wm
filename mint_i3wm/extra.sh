#!/bin/sh

deps="nitrogen rxvt-unicode feh screenfetch scrot imagemagick i3lock"
way=$(pwd)
reset=$(tput sgr0)
highlight=$(tput setaf 6)

[ "$1" ] && flag="$1" || flag='-i'

if [ "$flag" = '-i' ] 2> /dev/null
then
    sudo apt install $deps -y

    echo "${highlight}Configuring terminal${reset}"
    cp -v $way/rxvtconf ~/.Xresources

    echo "${highlight}Configuring editor${reset}"
    cd /usr/local/bin/
    curl https://getmic.ro/r | sudo bash
    cd $way

    echo "${highlight}Configuring background wallpaper"
    echo 'Default path is /usr/share/backgrounds/linuxmint/'
    echo 'If you want to change the path after the installation type in terminal "nitrogen /your/path --set-zoom-fill"'
    echo "${reset}"
    sleep 0.5
    nitrogen /usr/share/backgrounds/linuxmint/default_background.jpg --set-zoom-fill --save 2> /dev/null

    cp -v ~/.profile ~/.profile.bak
    cp -v $way/profile ~/.profile

    echo "${highlight}Configuring lock screen${reset}"

    # This part is based on http://plankenau.com/blog/post/gaussianlock blurred lock screen tutorial

    echo '#!/bin/sh' >> lock
    echo 'scrot /tmp/screenshot.png' >> lock
    echo 'convert /tmp/screenshot.png -blur 0x9 /tmp/screenshotblurred.png' >> lock
    echo 'i3lock -i /tmp/screenshotblurred.png' >> lock
    echo 'rm /tmp/screenshotblurred.png' >> lock
    echo 'rm /tmp/screenshot.png' >> lock

    chmod +x lock
    sudo mv -v lock /bin/

elif [ "$flag" = '-u' ] 2> /dev/null
then

    sudo apt remove $deps -y

    echo "${highlight}Restoring terminal${reset}"
    rm -v ~/.Xresources

    echo "${highlight}Deconfiguring editor${reset}"
    sudo rm -v /usr/local/bin/micro

    echo "${highlight}Restoring profile${reset}"
    rm -v ~/.profile
    mv -v ~/.profile.bak ~/.profile

    echo "${highlight}Deconfiguring lock screen${reset}"
    sudo rm -v /bin/lock

else
    echo "${highlight}Invalid flag, please use a valid one (-i or -u).${reset}"
fi
