#!/usr/bin/env bash

export GOENV_ROOT="/opt/goenv"
export PATH="$PATH:${GOENV_ROOT}/bin"

eval "$(goenv init -)"

