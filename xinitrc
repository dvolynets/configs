##setxkbmap -option ctrl:swapcaps
##setxkbmap -option ctrl:nocaps

setxkbmap -layout 'us,ru' -option 'grp:lctrl_lwin_toggle'

make -C /home/dimav/dwm
exec /home/dimav/dwm/dwm
