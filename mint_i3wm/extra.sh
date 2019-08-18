#!/bin/bash

sudo apt install nitrogen rxvt-unicode feh screenfetch scrot imagemagick i3lock -y

dir=~/mint_i3wm
reset=$(tput sgr0)
highlight=$(tput setaf 6)

echo "${highlight}Configuring terminal${reset}"
cp $dir/rxvtconf ~/.Xresources

echo "${highlight}Configuring editor${reset}"
curl https://getmic.ro | bash
sudo mv micro /usr/bin/

echo "${highlight}Configuring background wallpaper"
echo 'Default path is /usr/share/backgrounds/linuxmint/'
echo 'If you want to change the path after the installation type in terminal "nitrogen /your/path --set-zoom-fill"'
echo "${reset}"
sleep 0.5
nitrogen /usr/share/backgrounds/linuxmint/default_background.jpg --set-zoom-fill

cp ~/.profile ~/.profile.bak
cp $dir/profile ~/.profile

echo "${highlight}Configuring lock screen${reset}"

# This part is based on http://plankenau.com/blog/post/gaussianlock blurred lock screen tutorial

echo '#!/bin/bash' >> $dir/lock
echo 'if [ ! -d ~/wallpapers ]' >> $dir/lock
echo 'then' >> $dir/lock
echo '    mkdir ~/wallpapers' >> $dir/lock
echo 'fi' >> $dir/lock
echo 'scrot ~/wallpapers/screenshot.png' >> $dir/lock
echo 'convert ~/wallpapers/screenshot.png -blur 0x9 ~/wallpapers/screenshotblurred.png' >> $dir/lock
echo 'i3lock -i ~/wallpapers/screenshotblurred.png' >> $dir/lock
echo 'rm ~/wallpapers/screenshotblurred.png' >> $dir/lock

chmod +x $dir/lock
sudo mv $dir/lock /bin/
