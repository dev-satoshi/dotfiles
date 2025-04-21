#!/usr/bin/env zsh
set -euo pipefail

echo "「dotfiles」のセットアップを開始しました"

INSTALL_DIR="$HOME/dotfiles"

sh "$INSTALL_DIR/scripts/homebrew_setup.sh"
sh "$INSTALL_DIR/scripts/asdf_setup.sh"
echo "「dotfiles」のセットアップが完了しました"
