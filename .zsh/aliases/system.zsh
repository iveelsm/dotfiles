#!/usr/bin/env zsh

# cd typo alias
alias cd..='cd ..'

# More informative commands
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# always make full path
alias mkdir='mkdir -p -v'


# ls aliases
alias ls='ls -alhF --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# color aliases
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'