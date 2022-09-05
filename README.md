# mint_i3wm
It's a script that install _i3_ with blur effects in your _Linux Mint_

![Cinnamon](cinnamon.jpg)

## Installation

* After cloning, go to the terminal;
* type `cd mint_i3wm`; 
* and run `./install.sh`;

It was tested on _Linux Mint_ 19, 20 and 21. \
Don't type 'Y' when the question "Just run desktop part? [Y/n] " appears, just use it if something goes wrong on the final of the installation. \
The script is made to work on the three default Desktop Environments in _Linux Mint_ (_Cinnamon_, _Mate_ and _Xfce_). Keep in mind that this script was made to work on a default _Linux Mint_ environment and that _Mate_ _i3_ applet isn't maintained anymore. \
In the newer versions of _Cinnamon_ it seems that not only the panel bar, but also the notification system now doesn't work with _i3_. Because of this behavior,  _deadd-notification-center_ is installed as a fallback.
The programs installed from *extra.sh* are: _nitrogen_ wallpaper setter, _rxvt-unicode_ terminal, _feh_ image viewer, _screenfetch_, _scrot_ screenshooter, _i3lock_ screenlocker for the lock script, and _micro_ text editor, with configs for some other programs already included on the configuration files. 

Also, part of the configuration files are based in _Manjaro i3_ config files and some parts of the code are based in tutorials from other websites and projects from github, mentions are inside of the scripts.

## Pos-Installation

I recommend you to use _polybar_ or _synaptic_ to find program names or to have access to them more easily.

If you have a problem in the installation or with a dependency issue, you just need to run a separated script again or remove the dependency and install it again. 

If you want to update one only need to run the scripts separately with the `-u` first and then run them again.

If you want to use another wallpaper changer instead of _nitrogen_ you can do it, on the _i3_ configuration files are an example for using the _feh_ program. \
I recommend that you use a dark theme for better look and feel and change the wallpaper, for this use the command `nitrogen /your/path/` or `nitrogen /your/path/ --set-zoom-fill` for avoiding size incompatibility.

## Uninstallation

* If you haven't anymore, clone it again;
* go to terminal, type `cd mint_i3wm` and run `./uninstall.sh`;

You can type 'Y' when the question "Just run desktop part?[Y/N] " appears, to remove only the desktop specific configurations applied. You can also uninstall or some programs using the separated scripts with the flag `-u`. \
Some programs are compiled again to uninstall them. Keep in mind, that if you move to other places or rename some directories and files, the script will not uninstall them. \
The unused dependencies remaining will be removed with `apt autoremove -y` automatically.

## Keyboard
$mod = Left Win key
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
* $mod+1 or $mod+2, $mod+3, ... $mod+8
### Change windows between workspaces
* $mod+Shift+1 or $mod+Shift+2 ... $mod+Shift+8
### Extra Features
* $mod+0 Command to exit (Return key in Mate to cancel)
* $mod+9 Command to lock screen
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
