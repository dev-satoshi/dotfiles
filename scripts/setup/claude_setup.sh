#!/usr/bin/env zsh
set -euo pipefail

echo "「Claude Code」のセットアップを開始しました"

# Claude Codeのインストール
if ! command -v claude >/dev/null 2>&1; then
  echo "「Claude Code」が見つかりません。インストールを開始します..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "「Claude Code」は既にインストールされています"
fi

echo "「Claude Code」のセットアップが完了しました"
