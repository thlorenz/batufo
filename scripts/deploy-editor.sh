#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/..
EDITOR=$ROOT/backend/packages/level-editor

GH_PAGES_ROOT=$ROOT/../batufo-gh
GH_PAGES_EDITOR=$GH_PAGES_ROOT/editor/

BUILD_WEB=$EDITOR/build

# clean old build
rm -rf $BUILD_WEB && (cd $EDITOR && yarn build)

rm -rf $GH_PAGES_EDITOR
cp -R $BUILD_WEB $GH_PAGES_EDITOR

(cd $GH_PAGES_ROOT && \
    git add editor && \
    git commit -m "editor: deploy" && \
    git push origin gh-pages && \
    git show HEAD --stat)
