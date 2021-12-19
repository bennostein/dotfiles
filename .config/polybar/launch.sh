#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch a main bar
polybar horizontal_top 2>&1 | tee -a /tmp/polybar.log & disown

# Launch spotify sub-bar if spotify is running
if pgrep -x spotify ; then polybar spotify & disown ; fi

echo "Polybar launched..."
