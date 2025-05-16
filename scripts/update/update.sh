#!/usr/bin/env zsh
set -euo pipefail

echo "「dotfiles」のアップデートを開始しました"

UPDATE_DIR="$HOME/dotfiles"

sh "$UPDATE_DIR/scripts/update/asdf_update.sh"
sh "$UPDATE_DIR/scripts/update/vscode_update.sh"

echo "「dotfiles」のアップデートが完了しました"
