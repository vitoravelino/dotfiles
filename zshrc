# exports
source ~/.exports

# custom aliases
source ~/.aliases

# antigen
source ~/.antigen/config

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load asdf
source ~/.asdf/asdf.sh

# rust
source ~/.asdf/installs/rust/1.74.1/env

# gpg
gpgconf --launch gpg-agent
