xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200

# disable touchpad on X1 Carbon (Gen 5)
xinput disable 11

xmodmap ~/.Xmodmap

xbindkeys

xrdb .Xresources

feh --bg-center ~/.wallpaper/monument_valley_wallpaper_1920x1080.png

setxkbmap de

redshift &

# xmonad
xmonad

# stumpwm
# /usr/bin/sbcl --load ~/.stumpwm.d/init.lisp
