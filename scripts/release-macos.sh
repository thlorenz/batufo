#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/..
CLIENT=$ROOT/client

(cd $CLIENT && \
    flutter build macos \
    --release \
    ./lib/main/desktop.release.dart)

ls -la $CLIENT/build/macos/Build/Products/Release/
