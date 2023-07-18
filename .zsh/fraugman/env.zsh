#!/usr/bin/env zsh

typeset -gA FRAUGMAN_ENV

# Loads the environment variables for the prompt
function load_env {
    declare -A FRAUGMAN_ENV
    FRAUGMAN_ENV[prompt]=';'
    FRAUGMAN_ENV[vi]=':'
    FRAUGMAN_ENV[debug]=1
}