#!/usr/bin/env zsh
set -euo pipefail

echo "「Homebrew」のアップデートを開始しました"

# パッケージリストを更新
brew update

# インストール済みのbrewパッケージを書き出す（VSCode関連を除く）
brew bundle dump --force --file=~/dotfiles/homebrew/Brewfile
sed -i '' '/^vscode /d' ~/dotfiles/homebrew/Brewfile

echo "「Homebrew」のアップデートが完了しました"
