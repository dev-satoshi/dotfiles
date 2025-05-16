#!/usr/bin/env zsh
set -euo pipefail

echo "「VSCode」のセットアップを開始しました"

# 拡張機能をインストール
xargs -L 1 code --install-extension < ~/dotfiles/vscode/extensions.txt

echo "「VSCode」のセットアップが完了しました"
