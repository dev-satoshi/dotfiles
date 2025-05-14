#!/usr/bin/env zsh
set -euo pipefail

echo "「シンボリックリンク」の作成を開始しました"

DOTFILES_DIR="$HOME/dotfiles"

# リンクを作成するファイル一覧（キー：シンボリックリンク先、値：dotfiles内の実ファイル）
LINKS=(
  "$DOTFILES_DIR/zsh/.zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/zsh/.zshenv:$HOME/.zshenv"
  "$DOTFILES_DIR/git/.gitconfig:$HOME/.gitconfig"
  "$DOTFILES_DIR/git/.gitignore:$HOME/.gitignore"
  "$DOTFILES_DIR/git/.gitattributes:$HOME/.gitattributes"
  "$DOTFILES_DIR/aws/config:$HOME/.aws/config"
  "$DOTFILES_DIR/vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json"
  "$DOTFILES_DIR/android/sdk:$HOME/Library/Android/sdk"
  "/opt/homebrew/share/android-commandlinetools/cmdline-tools/latest:$DOTFILES_DIR/android/sdk/cmdline-tools/latest"
)

# すべてのリンクを作成
for link in "${LINKS[@]}"; do
  src=$(echo "$link" | cut -d':' -f1)
  dest=$(echo "$link" | cut -d':' -f2)

  # 親ディレクトリが無ければ作成
  mkdir -p "$(dirname "$dest")"

  # 既存のファイルやリンクがあればバックアップ
  # if [ -e "$dest" ] || [ -L "$dest" ]; then
  #   echo "$dest をバックアップ: ${dest}.backup"
  #   mv "$dest" "${dest}.backup"
  # fi

  # 既存のファイルやリンクを削除（バックアップは取らない）
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "既存の $dest を削除"
    rm -rf "$dest"
  fi

  # シンボリックリンクを作成
  echo "$src → $dest"
  ln -s "$src" "$dest"
done

echo "「シンボリックリンク」の作成が完了しました"
