# mint_i3wm
It's a script that install _i3_ with blur effects in your _Linux_ _Mint_

![Cinnamon](cinnamon.jpg)

## Installation

* After cloning, move the mint_i3wm inside of this project directory to your home directory(`cp -r mint_i3wm ~/`);
* go to terminal;
* type `cd mint_i3wm`; 
* and run `./install.sh`;
* Then reboot your machine;

Don't type 'Y' when the question "Just run specific part?[Y/N] " appears because this option will run only the part where test which DE you are using and do specific modifications and instructions for it. \
Just use this option when you already used this script and if something is wrong, you can run one of the separated scripts too. \
The script may work on the three default Desktop Environments in Linux Mint. (_Cinnamon_, _Mate_ and _Xfce_) \
You can still install the i3 applet and plugin for _Mate_ and _Xfce_ by yourself, but they aren't brought with the other programs anymore because the `uninstall.sh` script could not uninstall them and _Mate_ i3 applet isn't maintained right now.

Part of the configuration files are based in Manjaro i3 configuration files and part of the code are based in tutorials from other sites and other projects for github, mentions are inside of the scripts.

## Pos-Installation

If you are in Cinnamon, in login screen click in _Cinnamon_ Logo and change to _Cinnamon+i3_, I recommend you to use _polybar_ or _synaptic_ to find program names or to have access to them more easily.

If you have a problem in the installation or with a dependence issue, you just need to run a separated script again or remove the dependence and install again with the flag `-i`. 

If you want to use another wallpaper changer instead of nitrogen you can do it. I recommend that you use a dark theme for better look and feel and change the wallpaper, for this use the command `nitrogen /your/path/ --set-zoom-fill` or `nitrogen /usr/share/backgrounds/linuxmint-tina/`.

## Uninstallation

* If you haven't anymore, clone it again and move the mint_i3wm directory to your home directory(`cp -r mint_i3wm ~/`);
* go to terminal, type `cd mint_i3wm` and run `./uninstall.sh`;
* Then reboot your machine;

Just type 'Y' when the question "Just run specific part?[Y/N] " appears, if something go wrong. You can uninstall some part or some programs using the separated scripts with the flag `-u`. \
Some programs are downloaded again to uninstall them. Also if you move to other places or rename some directories and files the script will not uninstall them, others will be created again in the default place to remove them. The unused dependencies remaining will be removed with `apt autoremove` automatically.

## Keyboard
$mod = Win key
### Main Applications
* $mod+Shift+t: Urxvt Terminal
* $mod+F2: Firefox Browser
* $mod+Shift+m: Dmenu 
* $mod+Ctrl+d: Rofi Menu
### Switch between windows
* $mod+arrow keys
### Switch scope between horizontal and vertical
* $mod+q
### Switch between workspaces
* $mod+1 or $mod+2...$mod+3...$mod+8
### Change windows between workspaces
* $mod+Shift+1 or $mod+Shift+2...$mod+Shift+8
### Extra Features
* $mod+0 Command to exit
* $mod+9 Command to lock screen(don't work on Mate)
* $Mod+Shift+r Reload i3
* $mod+Shift+Space Change focus tiling/float
* $mod+f Change to fullscreen
* $mod+m Unhide/hide i3bar

## More Images

Cinnamon configuration menu (wallpaper: Blue Mountains from Linux Mint Tina, Programs: Xed, default terminal of Mint, configuration menu)
![Appearance](cinnamon-editor.jpg)

i3 with Mate (wallpaper: Maldives from Linux Mint Tina, Programs: default terminal of Mint, urxvt and 'Mint-Y' default theme)
![Mate](mate_i3.jpg)

i3 with Xfce (Programs: default terminal of Mint, thunar file manager)
![Xfce](i3xfce.jpg)

Initial tests with just i3 (Programs: urxvt).
![i3](i3.jpg)
