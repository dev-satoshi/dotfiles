#!/usr/bin/env zsh
set -euo pipefail

echo "「Android」のセットアップを開始しました"

CMDLINE_TOOLS_DIR="/opt/homebrew/share/android-commandlinetools/cmdline-tools/latest"

if [ -d "$CMDLINE_TOOLS_DIR" ]; then
  :
else
  # パッケージをインストール
  sdkmanager --install "cmdline-tools;latest" \
                       "platform-tools" \
                       "platforms;android-34" \
                       "build-tools;34.0.0" \
                       "emulator"
fi

# Androidのライセンスに同意
yes | flutter doctor --android-licenses || true

echo "「Android」のセットアップが完了しました"
