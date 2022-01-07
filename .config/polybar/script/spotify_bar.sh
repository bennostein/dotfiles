if pgrep -ax "spotify" ; then
#    notify-send "got a spotify client"
    if ! pgrep -f "polybar spotify" >/dev/null ; then
#	notify-send "no polybar, starting"
	polybar spotify &
    fi
else
#    notify-send "no spotify client, killing polybar"
    pkill -f "polybar spotify"
fi
