#!/usr/bin/env zsh
set -euo pipefail

echo "「dotfiles」のアップデートを開始しました"

INSTALL_DIR="$HOME/dotfiles"

sh "$INSTALL_DIR/scripts/update/asdf_update.sh"

echo "「dotfiles」のアップデートが完了しました"
