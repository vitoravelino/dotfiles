# exports
source ~/.exports

# custom aliases
source ~/.aliases

# antigen
source ~/.antigen/config

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash