#!/usr/bin/env zsh

AWS_ROLE_METADATA="$HOME/.aws/_sts_role_metadata"
AWS_CLI="/usr/local/bin/aws"

declare -A AWS_PROFILES=( 
	[ops]="arn:aws:iam::211125638799:role/OrganizationAccountAccessRole"
	[mfa]="arn:aws:iam::137199715083:mfa/Pixel"
)

function awsswitch {
	NAME="$(basename "$0")"
	REGION=${AWS_REGION:-us-east-1}
	PROFILE=""

	function help {
		echo "${NAME} [-h|--help] [-r|--region <aws_region>] [-p|--profile <profile>] [-c|--current] [-l|--list]  authenticates an AWS session\n"
		echo "where:"
		echo "    -h|--help: override check for current session, exit after"
		echo "    -l|--list: list current available profiles and session details, exit after"
		echo "    -c|--current: list current in use profile and session details, exit after"
		echo "    -r|--region: region to switch to"
		echo "    -p|--profile: profile to switch to"
	}

	function list {
		echo "The following is a list of available options for awsswitch in key value pairs:"
		for key value in ${(@kv)AWS_PROFILES}; do
			echo "    ${key}: ${value}"
		done
	}

	function current {
		echo "The following is the current available metadata information:"
		cat $AWS_ROLE_METADATA
	}

	function parse_arguments {
		while [[ $# -gt 0 ]]; do
			option="${1}"
			case "${option}" in
				-h|--help)
					help
					shift
					return 1
					;;
				-l|--list)	
					list
					shift
					return 1
					;;
				-c|--current)
					current
					shift
					return 1
					;;
				-r|--region)
					REGION=${2}
					shift
					shift
					;;
				-p|--profile)
					PROFILE=${2}
					shift
					shift
					;;
				*)
					help
					shift
					return 2
				;;
			esac
		done
		return 0
	}

	function update_role_meta {
		local role=$1
		local profile=$2
		local region=$3

		metadata=$(jq -n \
				--arg role_arn "$role" \
				--arg region "$region" \
				--arg role "$profile" \
				'{arn: $role_arn, region: $region, role: $role}' )
		echo "$metadata" > $AWS_ROLE_METADATA
	}

	function swap_role {
		local profile=$1

		local session_id=$(aws --profile $profile configure get aws_access_key_id)
		local session_key=$(aws --profile $profile configure get aws_secret_access_key)
		local token=$(aws --profile $profile configure get aws_session_token)

		$AWS_CLI --profile default configure set aws_session_token $token
		$AWS_CLI --profile default configure set aws_access_key_id $session_id
		$AWS_CLI --profile default configure set aws_secret_access_key $session_key
	}

	parse_arguments $@
	resp=$?
	if [[ $resp -ne 0  ]]; then
		return $(($resp-1))
	fi
	
	update_role_meta $AWS_PROFILES[$PROFILE] $PROFILE $REGION
	swap_role $PROFILE
	return 0
}

function awswrap {
	NAME="$(basename "$0")"
	MFA_PROFILE="mfa"
	AWS_METADATA="$HOME/.aws/_sts_metadata"
	REGION="${AWS_REGION:-us-east-1}"
	ROLE_ARN=""
	ROLE=""
	CODE=""

	function awsrole {
		if [[ ! -e $AWS_ROLE_METADATA ]]; then
			touch $AWS_ROLE_METADATA
			return 1
		fi

		ROLE_ARN=$(jq -r .arn $AWS_ROLE_METADATA)
		ROLE=$(jq -r .role $AWS_ROLE_METADATA)
		REGION=$(jq -r .region $AWS_ROLE_METADATA)
		return 0
	}

	function awscheck {
		local meta_file=$1
		if [[ ! -e $meta_file ]]; then
			touch $meta_file
			return 1
		fi

		local expiration=$(jq -r .expiration $meta_file)
		local current=$(date -u +"%Y%m%d%H%M%S")
		local expires=$(date -jf "%Y-%m-%dT%H:%M:%S" $expiration +"%Y%m%d%H%M%S" 2>/dev/null)
		if [ -z "$expires" ]; then
			return 1
		elif [ $current -gt $expires ]; then
			return 1
		else
			return 0
		fi
	}

	function awsupdatecredentials {
		local profile=$1
		local region=$2
		local session_data=$3

		local token=$(echo "${session_data}" | jq -r '.Credentials.SessionToken')
		local session_id=$(echo "${session_data}" | jq -r '.Credentials.AccessKeyId')
		local session_key=$(echo "${session_data}" | jq -r '.Credentials.SecretAccessKey')

		$AWS_CLI --profile ${profile} configure set aws_session_token $token
		$AWS_CLI --profile ${profile} configure set aws_access_key_id $session_id
		$AWS_CLI --profile ${profile} configure set aws_secret_access_key $session_key
		$AWS_CLI --profile ${profile} configure set region $region
	}

	function awsassume {
		local aws_metadata="$HOME/.aws/_sts_assume_metadata"

		function replace_metadata {
			local region=$1
			local profile=$2
			local session_expiration=$(echo "${3}" | jq -r '.Credentials.Expiration')
			metadata=$(jq -n \
					--arg exp "$session_expiration" \
					--arg region "$region" \
					--arg profile "$profile" \
					'{expiration: $exp, region: $region, profile: $profile}' )
			echo "$metadata" > $aws_metadata
		}

		function assume_role {
			local role=$1
			local profile=$2
			local auth_response=$($AWS_CLI --profile $MFA_PROFILE sts assume-role \
				--duration-seconds 3600 \
				--role-arn ${role} \
				--role-session-name ${profile})

			if [[ "$auth_response" =~ .*"SessionToken".* ]]; then
				echo $auth_response
			fi
		}

		function assume {
			local role=$1
			local profile=$2
			local region=$3

			if [ -z "$role" ]; then
				printf "Role is not set in metadata, run awsswitch\n"
				return 1
			fi

			response=$(assume_role $role $profile)
			if [ -z "$response" ]; then 
				printf "Token retrieval failed, run command manually\n"
				return 1
			fi

			awsupdatecredentials $profile $region $response 
			awsupdatecredentials "default" $region $response 
			replace_metadata $region $profile $response
			return 0
		}

		role=$1
		profile=$2
		region=$3
	
		awscheck $aws_metadata
		result=$?
		if [[ result -eq 1 ]]; then
			output=$(assume $role $profile $region)
			result=$?
			if [[ ! result -eq 0 ]]; then
				return $result
			fi
		fi
	}

	function awslogin {
		local aws_credentials="$HOME/.aws/credentials"
		local aws_metadata="$HOME/.aws/_sts_metadata"

		function get_token {
			local serial=$2
			local token=$1
			local auth_response=$($AWS_CLI sts get-session-token \
				--duration-seconds 43200 \
				--serial-number ${serial} \
				--token-code ${token})

			if [[ "$auth_response" =~ .*"SessionToken".* ]]; then
				echo $auth_response
			fi
		}

		function replace_metadata {
			local region=$1
			local session_expiration=$(echo "${2}" | jq -r '.Credentials.Expiration')
			metadata=$(jq -n \
					--arg exp "$session_expiration" \
					--arg region "$region" \
					'{expiration: $exp, region: $region}' )
			echo "$metadata" > $aws_metadata
		}

		function login {
			local mfa_arn=$1
			local region=$2
			local code=$3

			truncate -s 0 $aws_credentials

			if [[ -z "$code" ]]; then
				printf "MFA Code required for authentication\n"
				return 1
			fi

			response=$(get_token $code $mfa_arn)
			if [ -z "$response" ]; then 
				printf "Token retrieval failed, run command manually\n"
				return 1
			fi

			awsupdatecredentials $MFA_PROFILE $region $response 
			awsupdatecredentials "default" $region $response 
			replace_metadata $region $response
			return 0
		}

		local mfa_arn=$1
		local region=$2
		local code=$3
		login $mfa_arn $region $code
		return $?
	}


	awscheck $AWS_METADATA
	result=$?
	if [[ result -eq 1 ]]; then
		read "MFA_CODE?Token expired, enter MFA code to continue: "
		output=$(awslogin $AWS_PROFILES[$MFA_PROFILE] $REGION $(echo $MFA_CODE | tr -d '\n'))
		result=$?
		if [ $result != 0 ]; then
			return $result
		fi
	fi

	awsrole
	if [ -z "$ROLE" ]; then
		printf "Role is not set in metadata, run awsswitch\n"
		return 1
	fi

	if [ $ROLE != "mfa" ]; then
		awsassume $ROLE_ARN $ROLE $REGION
		result=$?
		if [ $result != 0 ]; then
			echo "Wrap failed for $ROLE"
			return 1
		fi
	fi

	$AWS_CLI $@
}

alias switch=awsswitch
alias aws=awswrap