#!/usr/bin/zsh

function pathadd {
	local varname="PATH"
	local toadd=""

	function help {
		echo "Usage: pathadd [-p|--path <VAR>] <path-to-add>"
		echo ""
		echo "Options:"
		echo "  -p, --path <VAR>  Specify the variable to modify (default: PATH)"
		echo "  -h, --help        Show this help message"
	}

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			case "$1" in
				-p|--path)
					varname="$2"
					shift 2
					;;
				-h|--help)
					help
					return 0
					;;
				*)
					toadd="$1"
					shift
					;;
			esac
		done
	}

	parse_arguments "$@"

	if [[ -z "$toadd" ]]; then
		echo "Error: No path provided to add"
		help
		return 1
	fi

	local current_path="${(P)varname}"

	if [[ ":$current_path:" == *":$toadd:"* ]]; then
		echo "$toadd is already present in \$$varname"
	else
		current_path="$toadd:$current_path"
		typeset -g "${varname}=$current_path"
	fi
}
