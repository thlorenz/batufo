#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Instructions from: https://grpc.io/docs/quickstart/dart/
# Install protoc: https://github.com/google/protobuf/releases
# Install protoc plugin for dart: pub global activate protoc_plugin

echo "Make sure to run this from the root of the project"

dart_generated_dir=$DIR/../client/lib/rpc/generated
rm -rf "${generated_dir}/*"
protoc --dart_out=grpc:"${dart_generated_dir}" -Iprotos protos/message_bus.proto
