#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/..
CLIENT=$ROOT/client
BUILD=$ROOT/build/github

(mkdir -p $BUILD && rm -rf $BUILD/batufo.app && rm -f $BUILD/*)

$DIR/release-android.sh
$DIR/release-macos.sh

(cp $CLIENT/build/app/outputs/flutter-apk/app-release.apk \
    $BUILD/batufo.apk)

(cd $CLIENT/build/macos/Build/Products/Release/ && \
    zip -r $BUILD/batufo-macos.zip batufo.app > /dev/null)
