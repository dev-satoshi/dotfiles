#!/usr/bin/env zsh
set -euo pipefail

echo "「ASDF」のセットアップを開始しました"

# プラグインをインストール
while IFS=$'\t ' read -r name url; do
  asdf plugin add "$name" "$url" >/dev/null 2>&1 || true
done < ~/dotfiles/asdf/plugins.txt

# .tool-versions に書いてあるバージョンをインストール
while IFS=' ' read -r plugin version; do
  [[ -z "$plugin" || -z "$version" ]] && continue
  echo "→ Installing $plugin $version"
  asdf install "$plugin" "$version"
done < ~/dotfiles/asdf/.tool-versions

echo "「ASDF」のセットアップが完了しました"
