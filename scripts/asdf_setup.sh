#!/usr/bin/env zsh
set -euo pipefail

echo "「ASDF」のセットアップを開始しました"

# プラグインをインストール
while IFS=$' \t' read -r name url; do
  asdf plugin add "$name" "$url" >/dev/null 2>&1 || true
done < ~/dotfiles/asdf/plugins.txt

# .tool-versionsに書いてある全てのバージョンをインストール
while IFS= read -r line; do
  # 空行スキップ
  [[ -z "$line" ]] && continue

  # 先頭の単語がプラグイン名、残りがバージョン一覧
  set -- "$line"
  plugin=$1
  shift
  for version in "$@"; do
    echo "→ Installing $plugin $version"
    asdf install "$plugin" "$version"
  done
done < ~/dotfiles/asdf/.tool-versions

echo "「ASDF」のセットアップが完了しました"
