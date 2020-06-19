DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Hack around the fact that parcel doesn't properly adapt asset urls inside main.js,
# i.e. --public-url . only affects index.html.
# This will convert '__REPLACEURL__/' to  '' thus using relative imports.
# from: https://github.com/parcel-bundler/parcel/issues/206#issuecomment-565346971

ROOT=$DIR/..
cd $ROOT &&
./node_modules/.bin/parcel build index.html \
  -d ./build \
  -o index.html \
  --public-url '__REPLACEURL__' &&
MAIN_JS=`ls build/main*.js`
sed -i '' -e 's/__REPLACEURL__\///g' ./build/index.html
sed -i '' -e 's/__REPLACEURL__\///g' $MAIN_JS
