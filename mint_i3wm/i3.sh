#!/bin/sh
#!/bin/sh

# This is an automated script of 
# "https://benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/" 
# i3-gaps for ubuntu installation guide and on the i3-gaps wiki

[ "$1" ] && flag="$1" || flag='-i'

way=$(pwd)

buildXcbXrm() {
    git clone https://github.com/Airblader/xcb-util-xrm
    cd xcb-util-xrm
    git submodule update --init
    ./autogen.sh --prefix=/usr
    make
    sudo make install
    cd ..
}

build_i3() {
    git clone https://www.github.com/Airblader/i3
    cd i3
    meson -Ddocs=true -Dmans=true build
    cd build/
    meson compile
    sudo meson install -C .
    cd ../..
}

if [ "$flag" = '-i' ] 2> /dev/null
then
    sudo apt install git meson pkgconf automake automake1.11 libtool \
     libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
     libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
     libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
     libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev \
     libxcb-shape0-dev autoconf i3status asciidoc -y

    cd /tmp
    buildXcbXrm
    build_i3
    cd $way

    [ ! -d ~/.i3 ] && mkdir -v ~/.i3

    cp -v $way/i3 ~/.i3/config
    [ -d ~/.config/i3 ] && rm -rfv ~/.config/i3/

elif [ "$flag" = '-u' ] 2> /dev/null
then

    sudo rm -v /usr/local/bin/i3*
    sudo rm -v /usr/local/etc/i3*
    sudo mv -v /usr/local/share /usr/local/share.bak

    rm -rfv ~/.i3 /tmp/i3* /tmp/xcb-util-xrm

    sudo apt remove i3status -y

    sudo apt autoremove -y

else
    echo "${highlight}Invalid flag, please use a valid one (-i or -u).${reset}"
fi
