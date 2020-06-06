#!/usr/bin/env bash
set -euo pipefail

TITLE=${1:-'iPhone'}
TARGET=./lib/main/mobile.debug.dart
DEVICE=iPhone

TITLE=$TITLE flutter run -d $DEVICE $TARGET
