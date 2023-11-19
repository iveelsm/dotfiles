source ~/.zsh/env/env.zsh

local root=$HOME/.zsh
local fraugman=$root/fraugman
fpath+=$fraugman/

autoload -U promptinit; promptinit

prompt fraugman

# Aliases are simple loads and should be done first
source $root/aliases/aliases.zsh
# Functions define a base set of functions that can be used in loads later on
source $root/functions/functions.zsh
# Tools often rely on function definitions, and are the most complicated loads
source $root/tools/tools.zsh
# Company specific functions that are complex
source $root/company/company.zsh

eval $(thefuck --alias)
