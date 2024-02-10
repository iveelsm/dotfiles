#!/usr/bin/env zsh

typeset -Ug KUBECONFIG
export KUBECONFIG="${KUBECONFIG:-${HOME}/.kube/config}"

function kubelogin {
	NAME="$(basename "$0")"
	PROFILE=mfa
	CLUSTER=""

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			option="${1}"
			case "${option}" in
				-p|--profile)
					PROFILE="${2}"
					shift
					shift
					;;
				-h|--help)
					help
					return 0
					shift
					;;
				*)
					CLUSTER=$option
					break
					;;
			esac
		done
	}

	function help {
		echo "${NAME} [-h|--help] <cluster> generates kubernetes config for a given cluster\n"
		echo "where:"
		echo "    -p|--profile: override for default profile (mfa)"
		echo "    -h|--help: displays this help message"
		echo "    cluster: cluster to login to"
	}

	function login {
		if [ -z $CLUSTER ]; then
			printf "ERROR: Cluster is required.\n\n"
			help
			return 1
		fi

		aws eks update-kubeconfig \
			--profile mfa \
			--region us-east-1 \
			--name prd-eks-cluster
	}


	parse_arguments $@
	local resp=$?
	if [[ $resp -ne 0 ]]; then
		return $resp
	fi

	login
}