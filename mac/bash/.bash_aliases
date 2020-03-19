#!/bin/bash
#######################################################
# ALIASES
#######################################################

## Git

alias gs='git status'
alias pop='git stash pop'
alias stash='git add --all && git stash'
alias add='git add --all'
alias commit='git commit -m'
alias push='git push origin'

# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Repeat the last command with sudo prefixed
alias please='sudo $(fc -ln -1)'

# Open with default application
alias open='xdg-open'

# More informative commands
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
# always make full path
alias mkdir='mkdir -p -v'

# vi is vim
alias vi='vim'

# cd typo alias
alias cd..='cd ..'

# ls aliases
alias ls='ls -ahF --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# color aliases
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Compress files
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'

# Decompress files
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

#######################################################
# FUNCTIONS
#######################################################

#Automatically do an ls after each cd
cd() {
 	if [ -n "$1" ]; then
 		builtin cd "$@" && ls
 	else
 		builtin cd ~ && ls
 	fi
}

# Extract any archive(s) 
extract() {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}