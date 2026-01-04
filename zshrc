# exports
source ~/.exports

# antigen
source ~/.antigen/config

# custom aliases
source ~/.aliases

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# mise
eval "$(mise activate zsh)"

# completions
fpath+=$HOME/.rustup/zfunc

autoload -Uz compinit

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# zoxide
eval "$(zoxide init zsh)" 

# gpg
gpgconf --launch gpg-agent
