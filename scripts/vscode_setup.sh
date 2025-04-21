#!/usr/bin/env zsh
set -euo pipefail

echo "「VSCode」のセットアップを開始しました"

# 拡張機能を出力
code --list-extensions > ~/dotfiles/vscode/extensions.txt

# 拡張機能をインストール
cat ~/dotfiles/vscode/extensions.txt | xargs -L 1 code --install-extension

echo "「VSCode」のセットアップが完了しました"
