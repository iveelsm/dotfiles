#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do 
    sleep 1 
done

for m in $(polybar --list-monitors | cut -d":" -f1); do
    truncate -s 0 ~/.config/polybar/.logs/polybar_top_${m}.log
    MONITOR=$m polybar --log=info --reload top >> ~/.config/polybar/.logs/polybar_top_${m}.log 2>&1 & disown
    truncate -s 0 ~/.config/polybar/.logs/polybar_bottom_${m}.log
    MONITOR=$m polybar --log=info --reload bottom >> ~/.config/polybar/.logs/polybar_bottom_${m}.log 2>&1 & disown
done

echo "Polybar launched..."