#!/usr/bin/env bash

if [ "$(playerctl --player=spotify metadata --format "{{ title }} - {{ artist }}" >>/dev/null 2>&1; echo $?)" == "1" ]; then
    echo ""
else
  if [ "$(playerctl --player=spotify status)" == "Playing" ]; then
    echo "%{T2}%{T-}"
  else
    echo "%{T2}%{T-}"
  fi  
fi