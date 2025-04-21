# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# ASDF
export ASDF_DATA_DIR="$HOME/dotfiles/asdf"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit
