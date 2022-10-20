#!/usr/bin/env zsh

function compress {
	LOCATION=$(pwd)
	NAME="$(basename "$0")"
	EXTENSION="tar.gz"
	TO_COMPRESS=""

	help() {
		echo "${NAME} [-h] [-t type] [-c compress] compresses a file or directory\n"
		echo "where:"
		echo "    -h  show this help text"
		echo "    -t  type of file extension, defaults to tar.gz"
		echo "    -c  file or folder to compress"
	}

	function create_tar {
		compression_type="${1}"
		path_to_file="${2}"
		file_extension="${3}"
		tar "${compression_type}" -c -v -f "${path_to_file}.${file_extension}" "${path_to_file}"
	}

	function create_zip {
		path_to_file="${1}"
		if [ -d "${path_to_file}" ]; then
			zip -r "${path_to_file}.zip" "${path_to_file}"
		else 
			zip "${path_to_file}.zip" "${path_to_file}"
		fi
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
				-t|--type)	
					EXTENSION="${2}"
					shift
					shift
					;;
				-c|--compress)
					TO_COMPRESS="${2}"
					shift
					shift
					;;
				*)
					printf "Illegal option: -%s\n" "${OPTARG}" >&2
					help
					exit 1
				;;
			esac
		done
	}

	function direct_extension {	
		case "${EXTENSION}" in
			tar.gz)
				create_tar "-z" "${LOCATION}/${TO_COMPRESS}" "${EXTENSION}"
				;;
			tar.bz2)
				create_tar "-j" "${LOCATION}/${TO_COMPRESS}" "${EXTENSION}"
				;;
			zip)
				create_zip "${LOCATION}/${TO_COMPRESS}"
			;;
			*)
				printf "Unsupported extension: -%s\n" "${OPTARG}" >&2
				help
				exit 1
		esac
	}

	parse_arguments $@
	if [ -z "${TO_COMPRESS}" ]; then
		echo "Compression file argument required" >&2
		help
		exit 1
	fi
	direct_extension
}
