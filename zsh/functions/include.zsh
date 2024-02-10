#!/usr/bin/env zsh

function include {
	[[ -f "$1" ]] && source "$1" 2>/dev/null
}
