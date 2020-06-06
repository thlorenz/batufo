#!/usr/bin/env bash
set -euo pipefail

TITLE=${1:-'nexus'}
TARGET=./lib/main/mobile.debug.dart
DEVICE=nexus

TITLE=$TITLE flutter run -d $DEVICE $TARGET
