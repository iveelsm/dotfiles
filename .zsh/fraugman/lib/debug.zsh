#!/usr/bin/env zsh

# Debug function utilized for troubleshooting behaviors within the shell
# Requires setting an environment variable. Expected setting is as follows:
#  * FRAUGMAN_DEBUG=1
function _debug {
    if [[ ${FRAUGMAN_ENV[debug]:-0} == 1 ]]; then
        printf "[DEBUG] $@\n"
    fi
}