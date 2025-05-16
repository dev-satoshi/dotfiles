#!/usr/bin/env zsh
set -euo pipefail

INSTALL_DIR="$HOME/dotfiles"

if [ -d "$INSTALL_DIR" ]; then
  echo "Updating dotfiles..."
  git -C "$INSTALL_DIR" pull
else
  echo "Installing dotfiles..."
  git clone https://github.com/dev-satoshi/dotfiles "$INSTALL_DIR"
fi

sh "$INSTALL_DIR/scripts/setup/setup.sh"
