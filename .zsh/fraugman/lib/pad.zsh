#!/usr/bin/env zsh

# Evaluates two strings against the current terminal environment to build a padding.
# The padding is defined as the distance between the two strings.
# 
# The function takes three arguments:
#  1) left string
#  2) right string
#  3) padding character
# 
# Cases to be aware of:
#   * When only one argument is provided, the function will return the first argument.
#   * When only two arguments are provided, the function will default the padding character
#   * When insufficient terminal space is present, the right string will be dropped
#
# The resulting string will be a concatentation of left, right and padding in the following format
#   <left> + <pad> + <right>
function pad {
    function _help {
        printf "${NAME} {left} {right} [padding] builds a pad string\n\n"
    }

    function _length {
        emulate -L zsh
        local COLUMNS x y m
        COLUMNS=${2:-COLUMNS}
        y=${#1}

        if (( y )); then
            while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
                x=y
                (( y *= 2 ))
            done
            while (( y > x + 1 )); do
                (( m = x + (y - x) / 2 ))
                (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
            done
        fi

        echo $x
    }

    function _fill {
        local l r p
        l=$(_length $1)
        r=$(_length $2 9999)
        p=$((COLUMNS - l - r - ${ZLE_RPROMPT_INDENT:-1}))
        if (( p < 1 )); then
            echo "${1}"
        else
            echo "${1}${(pl.$p..$3.)}${2}"
        fi
    }

    if [[ $# < 2 ]]; then
        echo $1
        return
    fi

    left=$1
    right=$2
    pad=${3:- }

    echo "$(_fill $left $right $pad)"
}