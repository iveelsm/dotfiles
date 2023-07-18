source ~/.zsh/env/env.zsh

local root=$HOME/.zsh
local fraugman=$$root/fraugman
fpath+=$fraugman/

autoload -U promptinit; promptinit

prompt fraugman

source $root/aliases/aliases.zsh
source $root/company/company.zsh
source $root/functions/functions.zsh
source $root/tools/tools.zsh

eval $(thefuck --alias)