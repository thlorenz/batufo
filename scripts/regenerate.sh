#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Instructions from: https://grpc.io/docs/quickstart/dart/
# Install protoc: https://github.com/google/protobuf/releases
# Install protoc plugin for dart: pub global activate protoc_plugin
# Install protoc plugin for typescript: https://github.com/improbable-eng/ts-protoc-gen
# Install google-protobuf https://www.npmjs.com/package/google-protobuf

echo "Make sure to run this from the root of the project"

# typescript
protoc_gen_ts_path="$DIR/../backend/node_modules/.bin/protoc-gen-ts"

ts_generated_dir=$DIR/../backend/packages/core/src/generated
rm -f "${ts_generated_dir}/*"

# dart
dart_generated_dir=$DIR/../client/lib/rpc/generated
rm -f "${dart_generated_dir}/*"

protoc \
    --plugin="protoc-gen-ts=${protoc_gen_ts_path}" \
    --js_out="import_style=commonjs,binary:${ts_generated_dir}" \
    --ts_out="${ts_generated_dir}" \
    --dart_out=grpc:"${dart_generated_dir}" \
    -Iprotos protos/message_bus.proto

rm "${dart_generated_dir}/message_bus.pbjson.dart"
