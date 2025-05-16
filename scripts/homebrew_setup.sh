#!/usr/bin/env zsh
set -euo pipefail

echo "「Homebrew」のセットアップを開始しました"

# brewのインストール
if ! command -v brew >/dev/null 2>&1; then
  echo "「Homebrew」が見つかりません。インストールを開始します..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "「Homebrew」は既にインストールされています"
fi

# パッケージリストを更新
brew update

# Brewfileを元にインストール
brew bundle --file=~/dotfiles/homebrew/Brewfile

echo "「Homebrew」のセットアップが完了しました"
