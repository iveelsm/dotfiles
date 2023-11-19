#!/usr/bin/zsh

function pathadd {
	local pathname=""
	local toadd=""

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			option="${1}"
			case "${option}" in
				-p|--path)
					pathname="${2}"
					shift
					shift
					;;
				-h|--help)
					help
					shift
					exit 0
					;;
				*)
					toadd=$option
					break
				;;
			esac
		done
	}

	function help {
		echo "${NAME} [-h|--help] <pathtoadd> adds a value to the given path like variable\n"
		echo "where:"
		echo "    -p|--path: sets the path variable to manipulate, default is PATH"
		echo "    -h|--help: displays this help message"
		echo "    pathtoadd: path to add to the variable"
	}

	parse_arguments $@
	if [ -z $pathname ]; then
		pathname="PATH"
	fi

	case ":${(P)pathname}:" in
		*":$1:"*) 
			echo "$toadd is already present in ${(P)pathname}"
			;;
		*) 
			${(P)pathname}="$toadd:${(P)pathname}"
			;;
	esac

	export ${(P)pathname}
}