#!/usr/bin/env zsh
set -euo pipefail

echo "「VSCode → Cursor」の移行を開始しました"

# VSCodeの拡張機能を出力
code --list-extensions > ~/dotfiles/vscode/extensions.txt

# vscode/extensions.txtを１行ずつ読み込んでCursorにインストール
while IFS= read -r extension; do
  # 空行・コメント行はスキップ
  [[ -z "$extension" || "${extension:0:1}" == "#" ]] && continue

  # Cursorにインストール
  cursor --install-extension "$extension"
done < ~/dotfiles/vscode/extensions.txt

echo "「VSCode → Cursor」の移行が完了しました"
