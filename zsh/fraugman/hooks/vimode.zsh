#!/usr/bin/env bash

# Redraw the prompt when the vi mode changes.
# When the user enters vi command mode, the prompt changes
#
# Relies on FRAUGMAN_ENV[prompt]

NORMAL_MODE=':'
INSERT_MODE=';'

function vimode {
  emulate -L zsh
  local prompt_char=$INSERT_MODE
  case $KEYMAP in
    vicmd) 
      prompt_char=$NORMAL_MODE
      ;;
    viins|main)
      prompt_char=$INSERT_MODE
      ;;
    *) 
      prompt_char=$INSERT_MODE
      ;;
  esac

  zle && { zle .reset-prompt; zle -R; }

  echo "${prompt_newline}%(?.${prompt_char}.%F{${FRAUGMAN_COLORS[exit]:-red}}${prompt_char}%f) "
}