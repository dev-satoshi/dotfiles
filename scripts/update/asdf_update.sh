#!/usr/bin/env zsh
set -euo pipefail

echo "「ASDF」のアップデートを開始しました"

# プラグインを出力
asdf plugin list --urls > "$HOME/dotfiles/asdf/plugins.txt"

# 出力先ディレクトリがなければ作成
mkdir -p "$HOME/dotfiles/asdf"

# .tool-versionsを初期化
: > "$HOME/dotfiles/asdf/.tool-versions"

# 各プラグインの全バージョンを取得して出力
for plugin in $(asdf plugin list); do
  # 空行はスキップ
  [[ -z "$plugin" ]] && continue

  # バージョンリスト取得＆整形（行頭の空白、*、空行を削除）
  versions=$(asdf list "$plugin" 2>/dev/null \
             | sed -e 's/^[[:space:]]*\*\?[[:space:]]*//' -e '/^$/d')

  # それぞれのバージョンを.tool-versionsに出力
  for version in $versions; do
    echo "$plugin $version" >> "$HOME/dotfiles/asdf/.tool-versions"
  done
done

echo "「ASDF」のアップデートが完了しました"
