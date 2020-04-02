///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,unused_import
// ignore_for_file: unused_shown_name,return_of_invalid_type, ,library_prefixes,

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;

import 'message_bus.pb.dart' as $0;

export 'message_bus.pb.dart';

class GameUpdatesClient extends $grpc.Client {
  static final _$play = $grpc.ClientMethod<$0.PlayRequest, $0.PlayingClient>(
      '/GameUpdates/Play',
      ($0.PlayRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PlayingClient.fromBuffer(value));
  static final _$subscribeGameStates =
      $grpc.ClientMethod<$0.PlayingClient, $0.GameStateEvent>(
          '/GameUpdates/SubscribeGameStates',
          ($0.PlayingClient value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GameStateEvent.fromBuffer(value));
  static final _$playingClientSync =
      $grpc.ClientMethod<$0.PlayingClientEvent, $0.Empty>(
          '/GameUpdates/PlayingClientSync',
          ($0.PlayingClientEvent value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  GameUpdatesClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.PlayingClient> play($0.PlayRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$play, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseStream<$0.GameStateEvent> subscribeGameStates(
      $0.PlayingClient request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$subscribeGameStates, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<$0.Empty> playingClientSync(
      $async.Stream<$0.PlayingClientEvent> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$playingClientSync, request, options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class GameUpdatesServiceBase extends $grpc.Service {
  $core.String get $name => 'GameUpdates';

  GameUpdatesServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PlayRequest, $0.PlayingClient>(
        'Play',
        play_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PlayRequest.fromBuffer(value),
        ($0.PlayingClient value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlayingClient, $0.GameStateEvent>(
        'SubscribeGameStates',
        subscribeGameStates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.PlayingClient.fromBuffer(value),
        ($0.GameStateEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PlayingClientEvent, $0.Empty>(
        'PlayingClientSync',
        playingClientSync,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.PlayingClientEvent.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.PlayingClient> play_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PlayRequest> request) async {
    return play(call, await request);
  }

  $async.Stream<$0.GameStateEvent> subscribeGameStates_Pre(
      $grpc.ServiceCall call, $async.Future<$0.PlayingClient> request) async* {
    yield* subscribeGameStates(call, await request);
  }

  $async.Future<$0.PlayingClient> play(
      $grpc.ServiceCall call, $0.PlayRequest request);
  $async.Stream<$0.GameStateEvent> subscribeGameStates(
      $grpc.ServiceCall call, $0.PlayingClient request);
  $async.Future<$0.Empty> playingClientSync(
      $grpc.ServiceCall call, $async.Stream<$0.PlayingClientEvent> request);
}
