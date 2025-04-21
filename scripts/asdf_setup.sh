#!/usr/bin/env zsh
set -euo pipefail

echo "「ASDF」のセットアップを開始しました"

# プラグインを出力
asdf plugin list --urls > ~/dotfiles/asdf/plugins.txt

# プラグインをインストール
while read -r name url; do
  asdf plugin add "$name" "$url" || true
done < ~/dotfiles/asdf/plugins.txt

# 一括インストール
asdf install

echo "「ASDF」のセットアップが完了しました"
