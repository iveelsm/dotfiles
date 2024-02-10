#!/usr/bin/env zsh

# The following is a precmd hook for determining the git status and branch
# This function is typically called utilizing the async library
#
# There are no arguments to this function. The function is prone to breakage as well.
# The function depends on the particular format of messages within the git status call.
#
# The output of the function is <branch name> (<symbols>)
# The symbols are as follows:
#
#  & -> branch is behind remote
#  &* -> branch is diverged from remote
#  * -> branch is ahead of remote
#  + -> added files
#  x -> deleted files
#  ! -> modified files
#  > -> renamed or moved files
#  ? -> untracked files
#  $ -> there are stashed files
#
# The symbols are not configurable by default
function fraugman_hooks_git {
    emulate -L zsh

    local ref branch
    ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    case $? in       
        0)
            # $ref contains the name of a checked-out branch.
            ;;          
        128)
            # No Git repository here.
            return ;;  
        *)
            # HEAD is detached
            ref=$(command git rev-parse --short HEAD 2> /dev/null) || return ;;
    esac
    branch=${ref#refs/heads/}

    typeset -A messages
    messages=(
        '&*'  ' have diverged,'
        '&'   'Your branch is behind '
        '*'   'Your branch is ahead of '
        '+'   'new file:   '
        'x'   'deleted:    '
        '!'   'modified:   '
        '>'   'renamed:    '
        '?'   'Untracked files:'
    )

    if [[ -n $branch ]]; then
        local git_status symbols i=1 k

        git_status="$(LC_ALL=C GIT_OPTIONAL_LOCKS=0 command git status --show-stash 2>&1)"

        for k in '&*' '&' '*' '+' 'x' '!' '>' '?'; do
            case $git_status in
                *${messages[$k]}*) symbols+="$k" ;;
            esac
            (( i++ ))
        done

        # Check for stashed changes. If there are any, add the stash symbol to the
        # list of symbols.
        case $git_status in
            *'Your stash currently has '*)
                symbols+="\$"
                ;;
        esac

        if [[ -z "${symbols}" ]]; then 
            printf "$branch"
        else
            printf "$branch ($symbols)"
        fi
    fi
}