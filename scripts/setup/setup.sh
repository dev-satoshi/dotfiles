#!/usr/bin/env zsh
set -euo pipefail

echo "「dotfiles」のセットアップを開始しました"

INSTALL_DIR="$HOME/dotfiles"

sh "$INSTALL_DIR/scripts/setup/link_dotfiles.sh"
sh "$INSTALL_DIR/scripts/setup/homebrew_setup.sh"
sh "$INSTALL_DIR/scripts/setup/asdf_setup.sh"
sh "$INSTALL_DIR/scripts/setup/vscode_setup.sh"
sh "$INSTALL_DIR/scripts/setup/xcode_setup.sh"
sh "$INSTALL_DIR/scripts/setup/android_setup.sh"

echo "「dotfiles」のセットアップが完了しました"
