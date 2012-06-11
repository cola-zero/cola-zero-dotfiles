#!/bin/bash
export PATH=/home/.cabal/bin:$PATH
xrdb -merge ~/.Xresources &
xcompmgr -c &

xscreensaver -no-splash &

#display cursor
xsetroot -cursor_name left_ptr

#do not use touchpad
synclient TouchpadOff=1

#display background
feh --bg-fill .background.jpg &

#settings for ime
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon &

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 7 --transparent true --tint 0x191970 --height 13 &

wicd-gtk -t &
bluetooth-applet &
#skype &
dropbox &

#music
mpd &
gmpc &

exec /home/colazero/.cabal/bin/xmonad
