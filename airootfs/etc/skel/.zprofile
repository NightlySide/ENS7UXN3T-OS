#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# changer le fond d'écran
dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
var Desktops = desktops();                                
for (i=0;i<Desktops.length;i++) {
        d = Desktops[i];
        d.wallpaperPlugin = "org.kde.image";
        d.currentConfigGroup = Array("Wallpaper",
                                    "org.kde.image",
                                    "General");
        d.writeConfig("Image", "file:///usr/share/wallpapers/mountain_lake.png");
}'

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
