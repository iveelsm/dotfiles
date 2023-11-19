#!/usr/bin/env zsh

function realpath {
	local abspath=""
	local relpath=""

	function help {
		echo "${NAME} [-h|--help] <relativepath> prints the absolute path to a given location\n"
		echo "where:"
		echo "    -h|--help: displays this help message"
		echo "    relativepath: relative path to resolve"
	}

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			option="${1}"
			case "${option}" in
				-h|--help)
					help
					shift
					exit 0
					;;
				*)
					relpath="$1"
					shift
					;;
			esac
		done
	}

	function getpath {
		local path=$1
		if [ -d $path ] ; then
			local abspath=$(cd $path; pwd -P)
		else
			local prefix=$(cd $(dirname -- $path) ; pwd -P)
			local suffix=$(basename $path)
			local abspath="$prefix/$suffix"
		fi
		if [ -e $abspath ] ; then
			echo $abspath
		else
			echo 'error: does not exist'
		fi
	}

	parse_arguments $@
	getpath $relpath
}