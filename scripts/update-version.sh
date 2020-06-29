#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CLIENT=$DIR/../client

VERSION=`grep -e 'version:' $CLIENT/pubspec.yaml | cut -c10-`

echo "const BATUFO_VERSION = '$VERSION';" > $CLIENT/lib/generated_batufo_version.dart

git add "$CLIENT/pubspec.yaml"
git add "$CLIENT/lib/generated_batufo_version.dart"
git commit -m "chore: update version v$VERSION"
git tag "v$VERSION"

echo "https://github.com/thlorenz/batufo/releases/new?tag=v$VERSION"
