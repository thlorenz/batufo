#!/usr/bin/env bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT=$DIR/../../

cd $ROOT && \
git pull origin && \
cd $ROOT/backend && \
yarn && yarn build && \
sudo service batufo restart
