///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'message_bus.pb.dart' as $0;
export 'message_bus.pb.dart';

class GameUpdatesClient extends $grpc.Client {
  static final _$play = $grpc.ClientMethod<$0.Empty, $0.PlayingClient>(
      '/GameUpdates/Play',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlayingClient.fromBuffer(value));

  GameUpdatesClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.PlayingClient> play($0.Empty request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$play, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class GameUpdatesServiceBase extends $grpc.Service {
  $core.String get $name => 'GameUpdates';

  GameUpdatesServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.PlayingClient>(
        'Play',
        play_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.PlayingClient value) => value.writeToBuffer()));
  }

  $async.Future<$0.PlayingClient> play_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return play(call, await request);
  }

  $async.Future<$0.PlayingClient> play(
      $grpc.ServiceCall call, $0.Empty request);
}
