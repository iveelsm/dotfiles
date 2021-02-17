#!/usr/bin/env bash

DELIMITER="|"

declare -A ramps
declare -A colors

ramps["slow"]=▂
ramps["moderate"]=▅
ramps["fast"]=▇
ramps["abnormal"]=█

colors["slow"]='\033[0;32m'
colors["moderate"]='\033[0;33m'
colors["fast"]='\033[0:31m'
colors["abnormal"]='\033[0;35m'

fans=(
  "fan1"
  "fan2"
  "fan5" 
)

function fan_output {
  speed=$1
  #echo $2
  if [ $speed -lt 1000 ]; then
    echo "${ramps[slow]}"
  elif [ $speed -lt 1500 ]; then
    echo "${ramps[moderate]}"
  elif [ $speed -lt 2000 ]; then
    echo "${ramps[fast]}"
  else
    echo "${ramps[abnormal]}"
  fi
}

OUTPUT=""

for i in "${!fans[@]}"; do
  speed=$(sensors | grep ${fans[$i]} | awk '{ print $2 }')
  if [[ $i == $(("${#fans[@]}" - 1)) ]]; then
    toAppend=$(fan_output $speed ${fans[$i]})
    OUTPUT="${OUTPUT} $toAppend"
  else
    toAppend=$(fan_output $speed ${fans[$i]}) 
    OUTPUT="${OUTPUT} $toAppend "
  fi
done

echo $OUTPUT