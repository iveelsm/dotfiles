#!/usr/bin/env zshß

# Is the user connected via SSH?
#
# This function works perfectly for regular users. It is
# nearly impossible to detect with accuracy how a superuser
# is connected, so this prompt opts simply to display his or
function is_ssh {
	[[ -n ${SSH_CONNECTION-}${SSH_CLIENT-}${SSH_TTY-} ]]
}
