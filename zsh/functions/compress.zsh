#!/usr/bin/env zsh

function compress {
	local LOCATION=$(pwd)
	local NAME="${funcstack[1]}"
	local EXTENSION="tar.gz"
	local TO_COMPRESS=""

	function help {
		echo "${NAME} [-h] [-t type] [-c compress] compresses a file or directory"
		echo "where:"
		echo "    -h  show this help text"
		echo "    -t  type of file extension, defaults to tar.gz"
		echo "    -c  file or folder to compress"
	}

	function create_tar {
		local compression_flag="$1"
		local path_to_file="$2"
		local file_extension="$3"
		tar "$compression_flag" -cvf "${path_to_file}.${file_extension}" "${path_to_file}"
	}

	function create_zip {
		local path_to_file="$1"
		if [[ -d "$path_to_file" ]]; then
			zip -r "${path_to_file}.zip" "$path_to_file"
		else
			zip "${path_to_file}.zip" "$path_to_file"
		fi
	}

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			case "$1" in
				-h|--help)
					help
					return 0
					;;
				-t|--type)
					EXTENSION="$2"
					shift 2
					;;
				-c|--compress)
					TO_COMPRESS="$2"
					shift 2
					;;
				*)
					printf "Illegal option: %s\n" "$1" >&2
					help
					return 1
					;;
			esac
		done
	}

	function direct_extension {
		case "$EXTENSION" in
			tar.gz)
				create_tar "-z" "${LOCATION}/${TO_COMPRESS}" "$EXTENSION"
				;;
			tar.bz2)
				create_tar "-j" "${LOCATION}/${TO_COMPRESS}" "$EXTENSION"
				;;
			zip)
				create_zip "${LOCATION}/${TO_COMPRESS}"
				;;
			*)
				printf "Unsupported extension: %s\n" "$EXTENSION" >&2
				help
				return 1
				;;
		esac
	}

	parse_arguments "$@" || return $?

	if [[ -z "$TO_COMPRESS" ]]; then
		echo "Compression file argument required" >&2
		help
		return 1
	fi

	direct_extension
}
