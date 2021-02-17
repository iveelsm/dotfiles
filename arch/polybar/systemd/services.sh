#!/usr/bin/env bash
selected=$(systemctl list-unit-files --no-pager --type=service --no-legend | dmenu -l 10 -b -sb '#FFFFFF' -sf '#FF0000' -nb '#000000' | awk '{print $1;}')

selected=$(echo $selected | awk '{print $1;}')

if [ -z $selected ]; then
    exit 0
fi

echo $selected

action=$(echo -e "start\nstop\nrestart" | dmenu -l 3 -b -sb '#FFFFFF' -sf '#FF0000' -nb '#000000')

echo $action

case "$action" in
    "start")
        sudo systemctl start $selected
        ;;
    "stop")
        sudo systemctl stop $selected
        ;;
    "restart")
        sudo systemctl restart $selected
        ;;
esac