# exports
source ~/.exports

# antigen
source ~/.antigen/config

# custom aliases
source ~/.aliases

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load asdf
source ~/.asdf/asdf.sh

# completions
fpath=($HOME/.asdf/completions $fpath)
fpath+=$HOME/.rustup/zfunc

autoload -Uz compinit

if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# gpg
gpgconf --launch gpg-agent
