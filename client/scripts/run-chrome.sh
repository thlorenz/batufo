#!/usr/bin/env bash
set -euo pipefail

TITLE=${1:-'chrome'}
TARGET=./lib/main/web.debug.dart
DEVICE=chrome

echo "TITLE=$TITLE flutter run -d $DEVICE $TARGET"
TITLE=$TITLE flutter run -d $DEVICE $TARGET
