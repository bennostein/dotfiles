#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="horizontal_top"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
# Players supporting the MPRIS spec are supported.
# Examples: spotify, vlc, chrome, mpv and others.
# Use `playerctld` to always detect the latest player.
# See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
PLAYER="spotify"

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
FORMAT=" {{ trunc(title,30) }}  [{{ trunc(artist,20) }}] "

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
    while IFS= read -r id
    do
        polybar-msg -p "$id" hook $3 $2 1>/dev/null 2>&1
    done < <(echo "$1")
}

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

PLAY_PAUSE_OFF=1
PLAY_PAUSE_PLAYING=2
PLAY_PAUSE_PAUSED=3

NEXT_PREV_OFF=1
NEXT_PREV_ON=2

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "No music is playing"
    elif [ "$STATUS" = "Paused"  ]; then
        update_hooks "$PARENT_BAR_PID" "$PLAY_PAUSE_PAUSED" spotify-play-pause
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_ON" spotify-prev
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_ON" spotify-next
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    elif [ "$STATUS" = "No player is running"  ]; then
        update_hooks "$PARENT_BAR_PID" "$PLAY_PAUSE_OFF" spotify-play-pause
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_OFF" spotify-prev
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_OFF" spotify-next
	echo "" #gets rid of spotify-track module
    else
        update_hooks "$PARENT_BAR_PID" "$PLAY_PAUSE_PLAYING" spotify-play-pause
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_ON" spotify-prev
	update_hooks "$PARENT_BAR_PID" "$NEXT_PREV_ON" spotify-next
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    fi
fi

