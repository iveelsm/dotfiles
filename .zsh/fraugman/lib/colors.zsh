#!/usr/bin/env zsh

typeset -a FRAUGMAN_COLORS

# This function sets the colors for the prompt.
#
# There are a variety of supported themes. Themes are derived mostly from the color palettes at the following:
#   * https://github.com/Gogh-Co/Gogh
# 
# The resulting structure is defined in the exported variable FRAUGMAN_COLORS.
# The variable is an associative array, the relevant descriptions for each property are listed below:
#   FRAUGMAN_COLORS
#     --> theme: theme description
#     --> bg: background color for the terminal
#         ----> referenced by BACKGROUND_COLOR
#     --> fg: foreground color for the text
#         ----> referenced by FOREGROUND_COLOR
#     --> cursor: color of the cursor on the terminal
#         ----> referenced by FOREGROUND_COLOR (usually)
#     --> host: color for the hostname and username of the terminal
#         ----> referenced by COLOR_01
#     --> prompt: unknown currently
#         ----> referenced by COLOR_07
#     --> path: color for the current working directory
#         ----> referenced by COLOR_05
#     --> branch: color for the git status and current branch
#         ----> referenced by COLOR_13
#     --> failure: color for failure status code
#         ----> referenced by COLOR_10
#
# This function can be sourced in and is intended to be used dynamically within the prompt through the call:
#
#  $ colors chalkboard
# 
# Which will set the colors to the chalkboard settings referenced in the file moving forward.
function colors {
    # options=(
    #     "chalkboard"
    #     "obsidian"
    #     "twilight"
    #     "default"
    # )

    function _chalkboard {
        # export COLOR_01="#000000"           # HOST
        # export COLOR_02="#c37372"           # SYNTAX_STRING
        # export COLOR_03="#72c373"           # COMMAND
        # export COLOR_04="#c2c372"           # COMMAND_COLOR2
        # export COLOR_05="#7372c3"           # PATH
        # export COLOR_06="#c372c2"           # SYNTAX_VAR
        # export COLOR_07="#72c2c3"           # PROMP
        # export COLOR_08="#d9d9d9"           #

        # export COLOR_09="#323232"           #
        # export COLOR_10="#dbaaaa"           # COMMAND_ERROR
        # export COLOR_11="#aadbaa"           # EXEC
        # export COLOR_12="#dadbaa"           #
        # export COLOR_13="#aaaadb"           # FOLDER
        # export COLOR_14="#dbaada"           #
        # export COLOR_15="#aadadb"           #
        # export COLOR_16="#ffffff"           #

        # export BACKGROUND_COLOR="#29262f"   # Background Color
        # export FOREGROUND_COLOR="#d9e6f2"   # Text
        # export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
        # export PROFILE_NAME="Chalkboard"

        FRAUGMAN_COLORS[theme]="Chalkboard"
        FRAUGMAN_COLORS[bg]="29262f"
        FRAUGMAN_COLORS[fg]="d9e6f2"
        FRAUGMAN_COLORS[cursor]="d9e6f2"
        FRAUGMAN_COLORS[host]="000000"
        FRAUGMAN_COLORS[prompt]="72c2c3"
        FRAUGMAN_COLORS[path]="7372c3"
        FRAUGMAN_COLORS[branch]="aaaadb"
        FRAUGMAN_COLORS[failure]="dbaaaa"
    }

    function _obsidian {
        # export COLOR_01="#000000"           # HOST
        # export COLOR_02="#a60001"           # SYNTAX_STRING
        # export COLOR_03="#00bb00"           # COMMAND
        # export COLOR_04="#fecd22"           # COMMAND_COLOR2
        # export COLOR_05="#3a9bdb"           # PATH
        # export COLOR_06="#bb00bb"           # SYNTAX_VAR
        # export COLOR_07="#00bbbb"           # PROMP
        # export COLOR_08="#bbbbbb"           #

        # export COLOR_09="#555555"           #
        # export COLOR_10="#ff0003"           # COMMAND_ERROR
        # export COLOR_11="#93c863"           # EXEC
        # export COLOR_12="#fef874"           #
        # export COLOR_13="#a1d7ff"           # FOLDER
        # export COLOR_14="#ff55ff"           #
        # export COLOR_15="#55ffff"           #
        # export COLOR_16="#ffffff"           #

        # export BACKGROUND_COLOR="#283033"   # Background Color
        # export FOREGROUND_COLOR="#cdcdcd"   # Text
        # export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
        # export PROFILE_NAME="Obsidian"

        FRAUGMAN_COLORS[theme]="Obsidian"
        FRAUGMAN_COLORS[bg]="283033"
        FRAUGMAN_COLORS[fg]="cdcdcd"
        FRAUGMAN_COLORS[cursor]="cdcdcd"
        FRAUGMAN_COLORS[host]="000000"
        FRAUGMAN_COLORS[prompt]="00bbbb"
        FRAUGMAN_COLORS[path]="3a9bdb"
        FRAUGMAN_COLORS[branch]="a1d7ff"
        FRAUGMAN_COLORS[failure]="ff0003"
    }

    function _twilight {
        # export COLOR_01="#141414"           # HOST
        # export COLOR_02="#c06d44"           # SYNTAX_STRING
        # export COLOR_03="#afb97a"           # COMMAND
        # export COLOR_04="#c2a86c"           # COMMAND_COLOR2
        # export COLOR_05="#44474a"           # PATH
        # export COLOR_06="#b4be7c"           # SYNTAX_VAR
        # export COLOR_07="#778385"           # PROMP
        # export COLOR_08="#ffffd4"           #

        # export COLOR_09="#262626"           #
        # export COLOR_10="#de7c4c"           # COMMAND_ERROR
        # export COLOR_11="#ccd88c"           # EXEC
        # export COLOR_12="#e2c47e"           #
        # export COLOR_13="#5a5e62"           # FOLDER
        # export COLOR_14="#d0dc8e"           #
        # export COLOR_15="#8a989b"           #
        # export COLOR_16="#ffffd4"           #

        # export BACKGROUND_COLOR="#141414"   # Background Color
        # export FOREGROUND_COLOR="#ffffd4"   # Text
        # export CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
        # export PROFILE_NAME="Twilight"

        FRAUGMAN_COLORS[theme]="Twilight"
        FRAUGMAN_COLORS[bg]="141414"
        FRAUGMAN_COLORS[fg]="ffffd4"
        FRAUGMAN_COLORS[cursor]="ffffd4"
        FRAUGMAN_COLORS[host]="141414"
        FRAUGMAN_COLORS[prompt]="778385"
        FRAUGMAN_COLORS[path]="44474a"
        FRAUGMAN_COLORS[branch]="5a5e62"
        FRAUGMAN_COLORS[failure]="de7c4c"
    }

    function _default {
        FRAUGMAN_COLORS[theme]="Default"
        FRAUGMAN_COLORS[bg]="default"
        FRAUGMAN_COLORS[fg]="white"
        FRAUGMAN_COLORS[cursor]="default"
        FRAUGMAN_COLORS[host]="green"
        FRAUGMAN_COLORS[prompt]="default"
        FRAUGMAN_COLORS[dir]="blue"
        FRAUGMAN_COLORS[branch]="yellow"
        FRAUGMAN_COLORS[failure]="red"
    }

    function _help {
		printf "${NAME} {option} sets the color of the prompt\n\n"
		printf "where available options are:\n"
		echo "    obsidian"
		echo "    chalkboard"
		echo "    twilight"
    }
    
    _default

    while [[ $# -gt 0 ]]; do
        option="${1}"
        case "${option}" in
            -h|--help)
                help
                exit 0
                ;;
            obsidian)
                _obsidian
                shift
                ;;
            chalkboard)	
                _chalkboard
                shift
                ;;
            twilight)
                _twilight
                shift
                ;;
            *)
                printf "Unsupported option passed: ${option}\n"
                help
                exit 1
                ;;
        esac
    done
}