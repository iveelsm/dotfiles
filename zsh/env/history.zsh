#!/usr/bin/env zsh

export HISTSIZE=10000000
export HISTFILESIZE=20000000

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS