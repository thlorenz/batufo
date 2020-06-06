#!/usr/bin/env bash
set -euo pipefail

TITLE=${1:-'macos'}
TARGET=./lib/main/desktop.debug.dart
DEVICE=macos

echo "TITLE=$TITLE flutter run -d $DEVICE $TARGET"
TITLE=$TITLE flutter run -d $DEVICE $TARGET
