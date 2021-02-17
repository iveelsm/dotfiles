#!/usr/bin/env bash

dir="~/.config/rofi/powermenu"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/powermenu.rasi"

# Options
exit=" Exit"
shutdown=" Shutdown"
reboot=" Restart"
suspend=" Sleep"
logout=" Logout"

# Variable passed to rofi
options="$exit\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $exit)
      exit 0
      ;;
    $shutdown)
      systemctl poweroff
      ;;
    $reboot)
      systemctl reboot
      ;;
    $suspend)
			systemctl suspend
      ;;
    $logout)
			i3-msg exit
      ;;
esac