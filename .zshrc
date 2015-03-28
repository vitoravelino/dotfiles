# Path to your oh-my-zsh installation.
export ZSH=/Users/vitoravelino/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew git gitfast git-extras sublime rvm bundler gem osx bower npm heroku)

# User configuration

source ~/.exports
source ~/.config
source ~/.aliases
source $ZSH/oh-my-zsh.sh # needs to be the last one