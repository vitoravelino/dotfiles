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

# rust
source ~/.asdf/installs/rust/1.74.1/env

# gpg
gpgconf --launch gpg-agent
