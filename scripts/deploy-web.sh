#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/..
CLIENT=$ROOT/client

GH_PAGES_ROOT=$ROOT/../batufo-gh
GH_PAGES_GAME=$GH_PAGES_ROOT/webgame/

BUILD_WEB=$CLIENT/build/web

# clean old build
rm -rf $BUILD_WEB

# build which requires us to link main.dart as dart2js runs into
# issues if we point the build directly at the file we're building
ln -s $CLIENT/lib/main/web.release.dart $CLIENT/lib/main.dart
(cd $CLIENT && flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true)
rm $CLIENT/lib/main.dart 

# safe current index.html which does not load service worker and avoid
# copying it
cp $GH_PAGES_GAME/index.html $BUILD_WEB
rm $BUILD_WEB/flutter_service_worker.js

# now our build directory is perfect and we can copy it
rm -rf $GH_PAGES_GAME
cp -R $BUILD_WEB $GH_PAGES_GAME

(cd $GH_PAGES_ROOT && \
    git add webgame && \
    git commit -m "game: deploy" && \
    git push origin gh-pages && \
    git show HEAD --stat)
