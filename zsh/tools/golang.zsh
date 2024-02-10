#!/usr/bin/env zsh 

export GOENV_ROOT="/opt/goenv"
export PATH="$GOENV_ROOT/bin:$PATH"

eval "$(goenv init -)"