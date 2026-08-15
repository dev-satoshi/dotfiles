#!/usr/bin/env zsh
set -euo pipefail

echo "「Android」のセットアップを開始しました"

# SDK 全体を指すディレクトリ（IDE からはこっちを見せる）
SDK_ROOT="$HOME/Library/Android/sdk"

# エミュレータのシステムイメージ（Apple Silicon: arm64-v8a、Intel: x86_64）
if [ "$(uname -m)" = "arm64" ]; then
  SYSTEM_IMAGE_ABI="arm64-v8a"
else
  SYSTEM_IMAGE_ABI="x86_64"
fi

# Homebrew 版の sdkmanager が使えるか確認
if ! command -v sdkmanager >/dev/null; then
  echo "ERROR: sdkmanager が見つかりません。PATH を確認してください。" >&2
  exit 1
fi

sdkmanager --sdk_root="$SDK_ROOT" \
            --install \
              "cmdline-tools;latest" \
              "platform-tools" \
              "platforms;android-35" \
              "system-images;android-35;google_apis_playstore;$SYSTEM_IMAGE_ABI" \
              "build-tools;35.0.1" \
              "build-tools;36.0.0" \
              "sources;android-35" \
              "emulator"

# Androidのライセンスに同意
yes | flutter doctor --android-licenses || true

# FlutterにSDKパスを教える
flutter config --android-sdk "$SDK_ROOT"

echo "「Android」のセットアップが完了しました"
