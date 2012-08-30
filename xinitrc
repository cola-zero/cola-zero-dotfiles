#!/bin/bash
. ~/.xprofile
export PATH=$HOME/.cabal/bin:$HOME/opt/bin:$PATH
xrdb -merge ~/.Xresources &
xcompmgr -c &
setxkbmap -option ctrl:swapcaps

xscreensaver -no-splash &

#display cursor
xsetroot -cursor_name left_ptr

#do not use touchpad
synclient TouchpadOff=1

#display background
feh --bg-fill .background.jpg &

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 7 --transparent true --tint 0x191970 --height 21 &

#settings for ime
source $HOME/.xinputrc
ibus-daemon -d -r -R -x &

wicd-gtk -t &
#bluetooth-applet &
#skype &
dropbox &

#music
mpd &
gmpc &

exec xmonad
#/home/colazero/opt/stumpwm/bin/stumpwm
