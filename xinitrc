#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export LANG=ja_JP.UTF-8
xrdb -merge ~/.Xresources &
xcompmgr -c &
setxkbmap -option ctrl:swapcaps

xrandr --dpi 125

xscreensaver -no-splash &

#display cursor
xsetroot -cursor_name left_ptr

#key repeat
xset r rate 230 25

#do not use touchpad
synclient TouchpadOff=1

#display background
feh --bg-fill ~/.background.jpg &

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 21 &

# #settings for ime
# #export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache
# #gtk-query-immodules-2.0
# #export GTK_IM_MODULE_FILE=$HOME/.gtk-immodules
export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
# export XMODIFIERS=@im=ibus
# #source $HOME/.xinputrc
# #export LANG="ja_JP.UTF-8"
# export XMODIFIERS="@im=ibus"
# export XMODIFIER="@im=ibus"
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# #export DefaultIMModule=ibus
# ibus-daemon -d -r -R &

export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
uim-toolbar-gtk-systray &
export XMODIFIERS=@im='uim'

wicd-gtk -t &
#bluetooth-applet &
#skype &
dropbox &

#music
mpd &
gmpc &

quasselclient &

synapse -s &

setxkbmap us
xmodmap $HOME/.Xmodmap

DEFAULT_SESSION=xmonad

case $1 in
  xmonad)
    exec xmonad
    ;;
  kde)
    exec startkde
    ;;
  xfce4)
    exec startxfce4
    ;;
  icewm)
    icewmbg &
    icewmtray &
    exec icewm
    ;;
  wmaker)
    exec wmaker
    ;;
  blackbox)
    exec blackbox
    ;;
  *)
    exec $DEFAULT_SESSION
    ;;
esac
#exec xmonad
#/home/colazero/opt/stumpwm/bin/stumpwm
