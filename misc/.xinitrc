setxkbmap us
xset b off
xsetroot -cursor_name left_ptr
unclutter &
feh --bg-scale /home/petar/archwall.png
urxvtd -q -o -f
xset fp+ /usr/share/fonts/TTF/
xset fp rehash
#xcompmgr -cC &
#cairo-compmgr &
compton --config ~/.compton.conf -b
xhost
#exec xmonad > $HOME/.xmonad/log.txt 2>&1
mpd
exec xmonad
