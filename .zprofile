eval "$(/opt/homebrew/bin/brew shellenv)"

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Configure PATH
export PATH="$HOME/.local/bin":$PATH

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
