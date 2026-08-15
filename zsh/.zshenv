# Homebrew（Apple Silicon: /opt/homebrew、Intel: /usr/local）
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# OrbStack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
