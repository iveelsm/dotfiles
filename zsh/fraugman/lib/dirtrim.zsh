#!/usr/bin/env zsh

# Trims a directory to a usable size.
# The usable size is defined as:
#   * 40 characters
#   * 3 directories
# Whichever is the smaller of the options. It also will apply general truncation techniques.
# 
# Example inputs and outputs listed below
#
# Given...
#   * /home/user/foobar/baz/
# We would instead see 
#   * ~/foobar/baz/
# 
# Given...
#   * /var/lib/postgres/data/01234bgsdfhwee/
# We would instead see...
#   * /var/.../data/01234bgsdfhwee/
#
# Given...
#   * /var/lib/a_very_long_directory_name_that_needs_truncation
# We would instead see...
#  * /var/lib/a_very_long_directory_name_t...
# 
# This is done to maintain a reasonable space for other various properties of the terminal
# This value can be adjusted at any time using the top level constants
function dirtrim {
    local maximum_size=3
    local maximum_length=40
    local output=''

    macro="%($(($maximum_size+1))~|%-1~/…/%$(($maximum_size-1))~|%${maximum_size}~)"
    output=$(print -P $macro)

    if (( ${#output} > $maximum_length )); then
        printf "${output:0:(($maximum_length-3))}..."
    else
        printf $output
    fi
}