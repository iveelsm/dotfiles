export RBENV_ROOT=/opt/rbenv
export PATH=/opt/rbenv/shims:$PATH
eval "$(rbenv init -)"
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
