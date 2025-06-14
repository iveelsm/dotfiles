#!/usr/bin/env zsh

_debug "Loading tools from the environment..."

source $(dirname $0)/aws.zsh
source $(dirname $0)/gcloud.zsh
source $(dirname $0)/golang.zsh
source $(dirname $0)/kitty.zsh
source $(dirname $0)/kubectl.zsh
source $(dirname $0)/nvm.zsh
source $(dirname $0)/rbenv.zsh
source $(dirname $0)/sdkman.zsh
source $(dirname $0)/terraform.zsh

if [[ "$(uname)" == "Darwin" ]]; then
	source $(dirname $0)/brew.zsh
fi
