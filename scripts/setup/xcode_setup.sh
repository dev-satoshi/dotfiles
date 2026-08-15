#!/usr/bin/env zsh
set -euo pipefail

echo "「Xcode」のセットアップを開始しました"

# xcodebuildのライセンスを受諾
yes | sudo xcodebuild -license accept || true

echo "「Xcode」のセットアップが完了しました"
