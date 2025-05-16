#!/usr/bin/env zsh
set -euo pipefail

INSTALL_DIR="$HOME/dotfiles"

if [ ! -d "$INSTALL_DIR" ]; then
  echo "dotfiles not found in $INSTALL_DIR"
  echo "Please run 'install.sh' first."
  exit 1
fi

echo "Updating dotfiles..."
git -C "$INSTALL_DIR" pull

sh "$INSTALL_DIR/scripts/update/update.sh"
