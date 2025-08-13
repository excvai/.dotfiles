eval "$(/opt/homebrew/bin/brew shellenv)"

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Configure PATH
export PATH="$HOME/.local/bin":$PATH
export PATH=$HOME/development/flutter/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# Default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"

# Change path to config files
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
