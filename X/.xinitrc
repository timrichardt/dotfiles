# TrackPoint scrolling using the deprecated `evdev` driver
# xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
# xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
# xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200

# The kernel update 4.12.8 to 4.12.10 reintroduced a bug that
# causes TrackPoint/TrackPad malfunctioning (no button 2 reaction)
# sudo modprobe -r psmouse
# sudo modprobe psmouse proto=bare

# disable touchpad on X1 Carbon (Gen 5)
xinput disable 11

xbindkeys

xrdb .Xresources

feh --bg-center ~/.wallpaper/iontriangle1.png

setxkbmap de

redshift &

# No acceleration for TrackPoint
xinput --set-prop 12 'libinput Accel Speed' 0
xinput --set-prop 12 'libinput Accel Profile Enabled' 0, 0
xinput --set-prop 12 'libinput Accel Profile Enabled Default' 0, 0

# xmonad
xmonad

# stumpwm
# startstump
# stumpwm

# xmodmap /home/tim/.Xmodmap
