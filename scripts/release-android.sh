#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/..
CLIENT=$ROOT/client

(cd $CLIENT && \
    flutter build apk \
        --release \
        ./lib/main/mobile.release.dart)

ls -la $CLIENT/build/app/outputs/flutter-apk/app-release.apk
