#!/usr/bin/env zsh
set -euo pipefail

echo "「VSCode」のアップデートを開始しました"

# 拡張機能を出力
code --list-extensions > ~/dotfiles/vscode/extensions.txt

echo "「VSCode」のアップデートが完了しました"
