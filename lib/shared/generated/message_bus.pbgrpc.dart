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

class GameClient extends $grpc.Client {
  static final _$play = $grpc.ClientMethod<$0.PlayRequest, $0.PlayingClient>(
      '/Game/Play',
      ($0.PlayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlayingClient.fromBuffer(value));
  static final _$syncClientAndGameStates =
      $grpc.ClientMethod<$0.PlayingClientEvent, $0.GameStateEvent>(
          '/Game/SyncClientAndGameStates',
          ($0.PlayingClientEvent value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GameStateEvent.fromBuffer(value));

  GameClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.PlayingClient> play($0.PlayRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$play, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.GameStateEvent> syncClientAndGameStates(
      $async.Stream<$0.PlayingClientEvent> request,
      {$grpc.CallOptions options}) {
    final call =
        $createCall(_$syncClientAndGameStates, request, options: options);
    return $grpc.ResponseStream(call);
  }
}

abstract class GameServiceBase extends $grpc.Service {
  $core.String get $name => 'Game';

  GameServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PlayRequest, $0.PlayingClient>(
        'Play',
        play_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlayRequest.fromBuffer(value),
        ($0.PlayingClient value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlayingClientEvent, $0.GameStateEvent>(
        'SyncClientAndGameStates',
        syncClientAndGameStates,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.PlayingClientEvent.fromBuffer(value),
        ($0.GameStateEvent value) => value.writeToBuffer()));
  }

  $async.Future<$0.PlayingClient> play_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PlayRequest> request) async {
    return play(call, await request);
  }

  $async.Future<$0.PlayingClient> play(
      $grpc.ServiceCall call, $0.PlayRequest request);
  $async.Stream<$0.GameStateEvent> syncClientAndGameStates(
      $grpc.ServiceCall call, $async.Stream<$0.PlayingClientEvent> request);
}
