#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch a main bar
polybar horizontal_top 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
