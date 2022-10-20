#!/usr/bin/env zsh

function cd {
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi	
}
