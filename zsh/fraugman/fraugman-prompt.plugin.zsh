FRAUGMAN_ROOT="${0:A:h}"

source "$FRAUGMAN_ROOT/env.zsh"

source "$FRAUGMAN_ROOT/hooks/hooks.zsh"
source "$FRAUGMAN_ROOT/lib/lib.zsh"

# Handles PS1 intitialization
function _prompt {
    local left
    left=''

    # Print current number of background jobs
    left+="%(1j.[%j] .)"

    # Display currently logged in user
    left+="%B%F{${FRAUGMAN_COLORS[host]:-green}}%n%f%b "

    # Append current path
    left+="%F{${FRAUGMAN_COLORS[dir]:-blue}}$(dirtrim)%f"

    # Retrieve the git status
    git_status="%F{${FRAUGMAN_COLORS[host]:-yellow}}$(fraugman_hooks_git)%f"

    # Create a pad for the length of the terminal
    left=$(pad $left $git_status)

    # Add the prompt character and newline
    left+="${PROMPT_CHAR:-$(vimode)}"

    PS1="${left}"
}

#
function prompt_fraugman_cleanup {

}

#
function prompt_fraugman_preexec {

}

# Switches between modes, vi and non-vi
function zle-keymap-select {
    _prompt
    zle reset-prompt
    zle -R
}

# precmd hook for the prompt
# Defined below
#   * https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
function prompt_fraugman_precmd {
    _prompt
}

# Sets up the prompt for use.
# Handles the following:
#
#  1. Autoloads
#  2. Hook initialization
#  3. Keymap bindings
#  4. General setopts
#
# Runs only on terminal initialization
function prompt_fraugman_setup {
    typeset -g prompt_opts
    setopt prompt_subst
    load_env

    autoload -U compinit && compinit

	_debug "Initializing preexec and precmd hooks..."
    autoload -Uz add-zsh-hook
    add-zsh-hook preexec prompt_fraugman_preexec
    add-zsh-hook precmd prompt_fraugman_precmd

    bindkey -v
    zle -N zle-keymap-select

	_debug "Mapping keybinds..."
    keybinds

    prompt_cleanup prompt_fraugman_cleanup
}

prompt_fraugman_setup
