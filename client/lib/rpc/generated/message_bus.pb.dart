///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message_bus.pbenum.dart';

export 'message_bus.pbenum.dart';

class InfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InfoRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  InfoRequest._() : super();
  factory InfoRequest() => create();
  factory InfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InfoRequest clone() => InfoRequest()..mergeFromMessage(this);
  InfoRequest copyWith(void Function(InfoRequest) updates) => super.copyWith((message) => updates(message as InfoRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InfoRequest create() => InfoRequest._();
  InfoRequest createEmptyInstance() => create();
  static $pb.PbList<InfoRequest> createRepeated() => $pb.PbList<InfoRequest>();
  @$core.pragma('dart2js:noInline')
  static InfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InfoRequest>(create);
  static InfoRequest _defaultInstance;
}

class PlayRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlayRequest', createEmptyInstance: create)
    ..aOS(1, 'levelName', protoName: 'levelName')
    ..e<Platform>(2, 'platform', $pb.PbFieldType.OE, defaultOrMaker: Platform.MacOS, valueOf: Platform.valueOf, enumValues: Platform.values)
    ..hasRequiredFields = false
  ;

  PlayRequest._() : super();
  factory PlayRequest() => create();
  factory PlayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlayRequest clone() => PlayRequest()..mergeFromMessage(this);
  PlayRequest copyWith(void Function(PlayRequest) updates) => super.copyWith((message) => updates(message as PlayRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayRequest create() => PlayRequest._();
  PlayRequest createEmptyInstance() => create();
  static $pb.PbList<PlayRequest> createRepeated() => $pb.PbList<PlayRequest>();
  @$core.pragma('dart2js:noInline')
  static PlayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayRequest>(create);
  static PlayRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get levelName => $_getSZ(0);
  @$pb.TagNumber(1)
  set levelName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevelName() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevelName() => clearField(1);

  @$pb.TagNumber(2)
  Platform get platform => $_getN(1);
  @$pb.TagNumber(2)
  set platform(Platform v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlatform() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatform() => clearField(2);
}

class InfoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('InfoResponse', createEmptyInstance: create)
    ..pc<LevelInfo>(1, 'levels', $pb.PbFieldType.PM, subBuilder: LevelInfo.create)
    ..hasRequiredFields = false
  ;

  InfoResponse._() : super();
  factory InfoResponse() => create();
  factory InfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  InfoResponse clone() => InfoResponse()..mergeFromMessage(this);
  InfoResponse copyWith(void Function(InfoResponse) updates) => super.copyWith((message) => updates(message as InfoResponse));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InfoResponse create() => InfoResponse._();
  InfoResponse createEmptyInstance() => create();
  static $pb.PbList<InfoResponse> createRepeated() => $pb.PbList<InfoResponse>();
  @$core.pragma('dart2js:noInline')
  static InfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InfoResponse>(create);
  static InfoResponse _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<LevelInfo> get levels => $_getList(0);
}

class ServerStatsUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ServerStatsUpdate', createEmptyInstance: create)
    ..a<$core.int>(1, 'totalGames', $pb.PbFieldType.OU3, protoName: 'totalGames')
    ..a<$core.int>(2, 'totalPlayers', $pb.PbFieldType.OU3, protoName: 'totalPlayers')
    ..m<$core.String, $core.int>(3, 'runningLevelsCounts', protoName: 'runningLevelsCounts', entryClassName: 'ServerStatsUpdate.RunningLevelsCountsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU3)
    ..m<$core.String, $core.int>(4, 'waitingForLevelsCounts', protoName: 'waitingForLevelsCounts', entryClassName: 'ServerStatsUpdate.WaitingForLevelsCountsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ServerStatsUpdate._() : super();
  factory ServerStatsUpdate() => create();
  factory ServerStatsUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerStatsUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ServerStatsUpdate clone() => ServerStatsUpdate()..mergeFromMessage(this);
  ServerStatsUpdate copyWith(void Function(ServerStatsUpdate) updates) => super.copyWith((message) => updates(message as ServerStatsUpdate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ServerStatsUpdate create() => ServerStatsUpdate._();
  ServerStatsUpdate createEmptyInstance() => create();
  static $pb.PbList<ServerStatsUpdate> createRepeated() => $pb.PbList<ServerStatsUpdate>();
  @$core.pragma('dart2js:noInline')
  static ServerStatsUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerStatsUpdate>(create);
  static ServerStatsUpdate _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalGames => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalGames($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalGames() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalGames() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPlayers => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPlayers($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPlayers() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPlayers() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.int> get runningLevelsCounts => $_getMap(2);

  @$pb.TagNumber(4)
  $core.Map<$core.String, $core.int> get waitingForLevelsCounts => $_getMap(3);
}

class PlayerDeparted extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlayerDeparted', createEmptyInstance: create)
    ..a<$core.int>(1, 'clientID', $pb.PbFieldType.OU3, protoName: 'clientID')
    ..hasRequiredFields = false
  ;

  PlayerDeparted._() : super();
  factory PlayerDeparted() => create();
  factory PlayerDeparted.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerDeparted.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlayerDeparted clone() => PlayerDeparted()..mergeFromMessage(this);
  PlayerDeparted copyWith(void Function(PlayerDeparted) updates) => super.copyWith((message) => updates(message as PlayerDeparted));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerDeparted create() => PlayerDeparted._();
  PlayerDeparted createEmptyInstance() => create();
  static $pb.PbList<PlayerDeparted> createRepeated() => $pb.PbList<PlayerDeparted>();
  @$core.pragma('dart2js:noInline')
  static PlayerDeparted getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerDeparted>(create);
  static PlayerDeparted _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get clientID => $_getIZ(0);
  @$pb.TagNumber(1)
  set clientID($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientID() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientID() => clearField(1);
}

class PlayerJoined extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlayerJoined', createEmptyInstance: create)
    ..a<$core.int>(1, 'clientID', $pb.PbFieldType.OU3, protoName: 'clientID')
    ..a<$core.int>(2, 'playerIndex', $pb.PbFieldType.OU3, protoName: 'playerIndex')
    ..hasRequiredFields = false
  ;

  PlayerJoined._() : super();
  factory PlayerJoined() => create();
  factory PlayerJoined.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerJoined.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlayerJoined clone() => PlayerJoined()..mergeFromMessage(this);
  PlayerJoined copyWith(void Function(PlayerJoined) updates) => super.copyWith((message) => updates(message as PlayerJoined));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerJoined create() => PlayerJoined._();
  PlayerJoined createEmptyInstance() => create();
  static $pb.PbList<PlayerJoined> createRepeated() => $pb.PbList<PlayerJoined>();
  @$core.pragma('dart2js:noInline')
  static PlayerJoined getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerJoined>(create);
  static PlayerJoined _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get clientID => $_getIZ(0);
  @$pb.TagNumber(1)
  set clientID($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientID() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientID() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get playerIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set playerIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlayerIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayerIndex() => clearField(2);
}

class LevelInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LevelInfo', createEmptyInstance: create)
    ..aOS(1, 'name')
    ..a<$core.int>(2, 'nplayers', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  LevelInfo._() : super();
  factory LevelInfo() => create();
  factory LevelInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LevelInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LevelInfo clone() => LevelInfo()..mergeFromMessage(this);
  LevelInfo copyWith(void Function(LevelInfo) updates) => super.copyWith((message) => updates(message as LevelInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LevelInfo create() => LevelInfo._();
  LevelInfo createEmptyInstance() => create();
  static $pb.PbList<LevelInfo> createRepeated() => $pb.PbList<LevelInfo>();
  @$core.pragma('dart2js:noInline')
  static LevelInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LevelInfo>(create);
  static LevelInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get nplayers => $_getIZ(1);
  @$pb.TagNumber(2)
  set nplayers($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNplayers() => $_has(1);
  @$pb.TagNumber(2)
  void clearNplayers() => clearField(2);
}

class PackedClientPlayerUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedClientPlayerUpdate', createEmptyInstance: create)
    ..aOM<PackedPlayerModel>(1, 'player', subBuilder: PackedPlayerModel.create)
    ..hasRequiredFields = false
  ;

  PackedClientPlayerUpdate._() : super();
  factory PackedClientPlayerUpdate() => create();
  factory PackedClientPlayerUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedClientPlayerUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedClientPlayerUpdate clone() => PackedClientPlayerUpdate()..mergeFromMessage(this);
  PackedClientPlayerUpdate copyWith(void Function(PackedClientPlayerUpdate) updates) => super.copyWith((message) => updates(message as PackedClientPlayerUpdate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedClientPlayerUpdate create() => PackedClientPlayerUpdate._();
  PackedClientPlayerUpdate createEmptyInstance() => create();
  static $pb.PbList<PackedClientPlayerUpdate> createRepeated() => $pb.PbList<PackedClientPlayerUpdate>();
  @$core.pragma('dart2js:noInline')
  static PackedClientPlayerUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedClientPlayerUpdate>(create);
  static PackedClientPlayerUpdate _defaultInstance;

  @$pb.TagNumber(1)
  PackedPlayerModel get player => $_getN(0);
  @$pb.TagNumber(1)
  set player(PackedPlayerModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayer() => clearField(1);
  @$pb.TagNumber(1)
  PackedPlayerModel ensurePlayer() => $_ensure(0);
}

class PackedClientSpawnedBulletUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedClientSpawnedBulletUpdate', createEmptyInstance: create)
    ..aOM<PackedBulletModel>(1, 'spawnedBullet', protoName: 'spawnedBullet', subBuilder: PackedBulletModel.create)
    ..hasRequiredFields = false
  ;

  PackedClientSpawnedBulletUpdate._() : super();
  factory PackedClientSpawnedBulletUpdate() => create();
  factory PackedClientSpawnedBulletUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedClientSpawnedBulletUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedClientSpawnedBulletUpdate clone() => PackedClientSpawnedBulletUpdate()..mergeFromMessage(this);
  PackedClientSpawnedBulletUpdate copyWith(void Function(PackedClientSpawnedBulletUpdate) updates) => super.copyWith((message) => updates(message as PackedClientSpawnedBulletUpdate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedClientSpawnedBulletUpdate create() => PackedClientSpawnedBulletUpdate._();
  PackedClientSpawnedBulletUpdate createEmptyInstance() => create();
  static $pb.PbList<PackedClientSpawnedBulletUpdate> createRepeated() => $pb.PbList<PackedClientSpawnedBulletUpdate>();
  @$core.pragma('dart2js:noInline')
  static PackedClientSpawnedBulletUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedClientSpawnedBulletUpdate>(create);
  static PackedClientSpawnedBulletUpdate _defaultInstance;

  @$pb.TagNumber(1)
  PackedBulletModel get spawnedBullet => $_getN(0);
  @$pb.TagNumber(1)
  set spawnedBullet(PackedBulletModel v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpawnedBullet() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpawnedBullet() => clearField(1);
  @$pb.TagNumber(1)
  PackedBulletModel ensureSpawnedBullet() => $_ensure(0);
}

class PackedClientSpawnedBombUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedClientSpawnedBombUpdate', createEmptyInstance: create)
    ..aOM<PackedTilePosition>(1, 'spawnPosition', protoName: 'spawnPosition', subBuilder: PackedTilePosition.create)
    ..hasRequiredFields = false
  ;

  PackedClientSpawnedBombUpdate._() : super();
  factory PackedClientSpawnedBombUpdate() => create();
  factory PackedClientSpawnedBombUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedClientSpawnedBombUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedClientSpawnedBombUpdate clone() => PackedClientSpawnedBombUpdate()..mergeFromMessage(this);
  PackedClientSpawnedBombUpdate copyWith(void Function(PackedClientSpawnedBombUpdate) updates) => super.copyWith((message) => updates(message as PackedClientSpawnedBombUpdate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedClientSpawnedBombUpdate create() => PackedClientSpawnedBombUpdate._();
  PackedClientSpawnedBombUpdate createEmptyInstance() => create();
  static $pb.PbList<PackedClientSpawnedBombUpdate> createRepeated() => $pb.PbList<PackedClientSpawnedBombUpdate>();
  @$core.pragma('dart2js:noInline')
  static PackedClientSpawnedBombUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedClientSpawnedBombUpdate>(create);
  static PackedClientSpawnedBombUpdate _defaultInstance;

  @$pb.TagNumber(1)
  PackedTilePosition get spawnPosition => $_getN(0);
  @$pb.TagNumber(1)
  set spawnPosition(PackedTilePosition v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSpawnPosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpawnPosition() => clearField(1);
  @$pb.TagNumber(1)
  PackedTilePosition ensureSpawnPosition() => $_ensure(0);
}

class GameCreated extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GameCreated', createEmptyInstance: create)
    ..a<$core.int>(1, 'gameID', $pb.PbFieldType.OU3, protoName: 'gameID')
    ..a<$core.int>(2, 'clientID', $pb.PbFieldType.OU3, protoName: 'clientID')
    ..a<$core.int>(3, 'playerIndex', $pb.PbFieldType.OU3, protoName: 'playerIndex')
    ..aOM<PackedArena>(4, 'arena', subBuilder: PackedArena.create)
    ..hasRequiredFields = false
  ;

  GameCreated._() : super();
  factory GameCreated() => create();
  factory GameCreated.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameCreated.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GameCreated clone() => GameCreated()..mergeFromMessage(this);
  GameCreated copyWith(void Function(GameCreated) updates) => super.copyWith((message) => updates(message as GameCreated));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameCreated create() => GameCreated._();
  GameCreated createEmptyInstance() => create();
  static $pb.PbList<GameCreated> createRepeated() => $pb.PbList<GameCreated>();
  @$core.pragma('dart2js:noInline')
  static GameCreated getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameCreated>(create);
  static GameCreated _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get gameID => $_getIZ(0);
  @$pb.TagNumber(1)
  set gameID($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameID() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameID() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get clientID => $_getIZ(1);
  @$pb.TagNumber(2)
  set clientID($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClientID() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientID() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get playerIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set playerIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPlayerIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlayerIndex() => clearField(3);

  @$pb.TagNumber(4)
  PackedArena get arena => $_getN(3);
  @$pb.TagNumber(4)
  set arena(PackedArena v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasArena() => $_has(3);
  @$pb.TagNumber(4)
  void clearArena() => clearField(4);
  @$pb.TagNumber(4)
  PackedArena ensureArena() => $_ensure(3);
}

class PackedPickup extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedPickup', createEmptyInstance: create)
    ..e<PackedPickupType>(1, 'type', $pb.PbFieldType.OE, defaultOrMaker: PackedPickupType.Medkit, valueOf: PackedPickupType.valueOf, enumValues: PackedPickupType.values)
    ..aOM<PackedTilePosition>(2, 'tilePosition', protoName: 'tilePosition', subBuilder: PackedTilePosition.create)
    ..hasRequiredFields = false
  ;

  PackedPickup._() : super();
  factory PackedPickup() => create();
  factory PackedPickup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedPickup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedPickup clone() => PackedPickup()..mergeFromMessage(this);
  PackedPickup copyWith(void Function(PackedPickup) updates) => super.copyWith((message) => updates(message as PackedPickup));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedPickup create() => PackedPickup._();
  PackedPickup createEmptyInstance() => create();
  static $pb.PbList<PackedPickup> createRepeated() => $pb.PbList<PackedPickup>();
  @$core.pragma('dart2js:noInline')
  static PackedPickup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedPickup>(create);
  static PackedPickup _defaultInstance;

  @$pb.TagNumber(1)
  PackedPickupType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(PackedPickupType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  PackedTilePosition get tilePosition => $_getN(1);
  @$pb.TagNumber(2)
  set tilePosition(PackedTilePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTilePosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTilePosition() => clearField(2);
  @$pb.TagNumber(2)
  PackedTilePosition ensureTilePosition() => $_ensure(1);
}

class PackedClientPickedUpUpdate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedClientPickedUpUpdate', createEmptyInstance: create)
    ..aOM<PackedPoint>(1, 'colRow', protoName: 'colRow', subBuilder: PackedPoint.create)
    ..hasRequiredFields = false
  ;

  PackedClientPickedUpUpdate._() : super();
  factory PackedClientPickedUpUpdate() => create();
  factory PackedClientPickedUpUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedClientPickedUpUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedClientPickedUpUpdate clone() => PackedClientPickedUpUpdate()..mergeFromMessage(this);
  PackedClientPickedUpUpdate copyWith(void Function(PackedClientPickedUpUpdate) updates) => super.copyWith((message) => updates(message as PackedClientPickedUpUpdate));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedClientPickedUpUpdate create() => PackedClientPickedUpUpdate._();
  PackedClientPickedUpUpdate createEmptyInstance() => create();
  static $pb.PbList<PackedClientPickedUpUpdate> createRepeated() => $pb.PbList<PackedClientPickedUpUpdate>();
  @$core.pragma('dart2js:noInline')
  static PackedClientPickedUpUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedClientPickedUpUpdate>(create);
  static PackedClientPickedUpUpdate _defaultInstance;

  @$pb.TagNumber(1)
  PackedPoint get colRow => $_getN(0);
  @$pb.TagNumber(1)
  set colRow(PackedPoint v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasColRow() => $_has(0);
  @$pb.TagNumber(1)
  void clearColRow() => clearField(1);
  @$pb.TagNumber(1)
  PackedPoint ensureColRow() => $_ensure(0);
}

class PackedArena extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedArena', createEmptyInstance: create)
    ..pc<PackedTilePosition>(1, 'floorTiles', $pb.PbFieldType.PM, protoName: 'floorTiles', subBuilder: PackedTilePosition.create)
    ..pc<PackedTilePosition>(2, 'walls', $pb.PbFieldType.PM, subBuilder: PackedTilePosition.create)
    ..pc<PackedTilePosition>(3, 'playerPositions', $pb.PbFieldType.PM, protoName: 'playerPositions', subBuilder: PackedTilePosition.create)
    ..a<$core.int>(4, 'nrows', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, 'ncols', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, 'tileSize', $pb.PbFieldType.OU3, protoName: 'tileSize')
    ..pc<PackedPickup>(7, 'pickups', $pb.PbFieldType.PM, subBuilder: PackedPickup.create)
    ..pc<PackedTeleport>(8, 'teleports', $pb.PbFieldType.PM, subBuilder: PackedTeleport.create)
    ..hasRequiredFields = false
  ;

  PackedArena._() : super();
  factory PackedArena() => create();
  factory PackedArena.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedArena.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedArena clone() => PackedArena()..mergeFromMessage(this);
  PackedArena copyWith(void Function(PackedArena) updates) => super.copyWith((message) => updates(message as PackedArena));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedArena create() => PackedArena._();
  PackedArena createEmptyInstance() => create();
  static $pb.PbList<PackedArena> createRepeated() => $pb.PbList<PackedArena>();
  @$core.pragma('dart2js:noInline')
  static PackedArena getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedArena>(create);
  static PackedArena _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PackedTilePosition> get floorTiles => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<PackedTilePosition> get walls => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<PackedTilePosition> get playerPositions => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get nrows => $_getIZ(3);
  @$pb.TagNumber(4)
  set nrows($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNrows() => $_has(3);
  @$pb.TagNumber(4)
  void clearNrows() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get ncols => $_getIZ(4);
  @$pb.TagNumber(5)
  set ncols($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNcols() => $_has(4);
  @$pb.TagNumber(5)
  void clearNcols() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get tileSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set tileSize($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTileSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearTileSize() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<PackedPickup> get pickups => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<PackedTeleport> get teleports => $_getList(7);
}

class PackedPlayerModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedPlayerModel', createEmptyInstance: create)
    ..a<$core.int>(1, 'id', $pb.PbFieldType.OU3)
    ..aOM<PackedTilePosition>(2, 'tilePosition', protoName: 'tilePosition', subBuilder: PackedTilePosition.create)
    ..aOM<PackedFractionalPoint>(3, 'velocity', subBuilder: PackedFractionalPoint.create)
    ..aOM<DoubleFourDecimals>(4, 'angle', subBuilder: DoubleFourDecimals.create)
    ..aOM<DoubleTwoDecimals>(5, 'health', subBuilder: DoubleTwoDecimals.create)
    ..a<$core.int>(6, 'shieldRemainingMs', $pb.PbFieldType.OU3, protoName: 'shieldRemainingMs')
    ..hasRequiredFields = false
  ;

  PackedPlayerModel._() : super();
  factory PackedPlayerModel() => create();
  factory PackedPlayerModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedPlayerModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedPlayerModel clone() => PackedPlayerModel()..mergeFromMessage(this);
  PackedPlayerModel copyWith(void Function(PackedPlayerModel) updates) => super.copyWith((message) => updates(message as PackedPlayerModel));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedPlayerModel create() => PackedPlayerModel._();
  PackedPlayerModel createEmptyInstance() => create();
  static $pb.PbList<PackedPlayerModel> createRepeated() => $pb.PbList<PackedPlayerModel>();
  @$core.pragma('dart2js:noInline')
  static PackedPlayerModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedPlayerModel>(create);
  static PackedPlayerModel _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  PackedTilePosition get tilePosition => $_getN(1);
  @$pb.TagNumber(2)
  set tilePosition(PackedTilePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTilePosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTilePosition() => clearField(2);
  @$pb.TagNumber(2)
  PackedTilePosition ensureTilePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  PackedFractionalPoint get velocity => $_getN(2);
  @$pb.TagNumber(3)
  set velocity(PackedFractionalPoint v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasVelocity() => $_has(2);
  @$pb.TagNumber(3)
  void clearVelocity() => clearField(3);
  @$pb.TagNumber(3)
  PackedFractionalPoint ensureVelocity() => $_ensure(2);

  @$pb.TagNumber(4)
  DoubleFourDecimals get angle => $_getN(3);
  @$pb.TagNumber(4)
  set angle(DoubleFourDecimals v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAngle() => $_has(3);
  @$pb.TagNumber(4)
  void clearAngle() => clearField(4);
  @$pb.TagNumber(4)
  DoubleFourDecimals ensureAngle() => $_ensure(3);

  @$pb.TagNumber(5)
  DoubleTwoDecimals get health => $_getN(4);
  @$pb.TagNumber(5)
  set health(DoubleTwoDecimals v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasHealth() => $_has(4);
  @$pb.TagNumber(5)
  void clearHealth() => clearField(5);
  @$pb.TagNumber(5)
  DoubleTwoDecimals ensureHealth() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get shieldRemainingMs => $_getIZ(5);
  @$pb.TagNumber(6)
  set shieldRemainingMs($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasShieldRemainingMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearShieldRemainingMs() => clearField(6);
}

class PackedBulletModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedBulletModel', createEmptyInstance: create)
    ..a<$core.int>(1, 'clientID', $pb.PbFieldType.OU3, protoName: 'clientID')
    ..aOM<PackedTilePosition>(2, 'tilePosition', protoName: 'tilePosition', subBuilder: PackedTilePosition.create)
    ..aOM<PackedFractionalPoint>(3, 'velocity', subBuilder: PackedFractionalPoint.create)
    ..hasRequiredFields = false
  ;

  PackedBulletModel._() : super();
  factory PackedBulletModel() => create();
  factory PackedBulletModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedBulletModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedBulletModel clone() => PackedBulletModel()..mergeFromMessage(this);
  PackedBulletModel copyWith(void Function(PackedBulletModel) updates) => super.copyWith((message) => updates(message as PackedBulletModel));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedBulletModel create() => PackedBulletModel._();
  PackedBulletModel createEmptyInstance() => create();
  static $pb.PbList<PackedBulletModel> createRepeated() => $pb.PbList<PackedBulletModel>();
  @$core.pragma('dart2js:noInline')
  static PackedBulletModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedBulletModel>(create);
  static PackedBulletModel _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get clientID => $_getIZ(0);
  @$pb.TagNumber(1)
  set clientID($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientID() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientID() => clearField(1);

  @$pb.TagNumber(2)
  PackedTilePosition get tilePosition => $_getN(1);
  @$pb.TagNumber(2)
  set tilePosition(PackedTilePosition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTilePosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTilePosition() => clearField(2);
  @$pb.TagNumber(2)
  PackedTilePosition ensureTilePosition() => $_ensure(1);

  @$pb.TagNumber(3)
  PackedFractionalPoint get velocity => $_getN(2);
  @$pb.TagNumber(3)
  set velocity(PackedFractionalPoint v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasVelocity() => $_has(2);
  @$pb.TagNumber(3)
  void clearVelocity() => clearField(3);
  @$pb.TagNumber(3)
  PackedFractionalPoint ensureVelocity() => $_ensure(2);
}

class PackedBombModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedBombModel', createEmptyInstance: create)
    ..aOM<PackedTilePosition>(1, 'tilePosition', protoName: 'tilePosition', subBuilder: PackedTilePosition.create)
    ..hasRequiredFields = false
  ;

  PackedBombModel._() : super();
  factory PackedBombModel() => create();
  factory PackedBombModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedBombModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedBombModel clone() => PackedBombModel()..mergeFromMessage(this);
  PackedBombModel copyWith(void Function(PackedBombModel) updates) => super.copyWith((message) => updates(message as PackedBombModel));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedBombModel create() => PackedBombModel._();
  PackedBombModel createEmptyInstance() => create();
  static $pb.PbList<PackedBombModel> createRepeated() => $pb.PbList<PackedBombModel>();
  @$core.pragma('dart2js:noInline')
  static PackedBombModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedBombModel>(create);
  static PackedBombModel _defaultInstance;

  @$pb.TagNumber(1)
  PackedTilePosition get tilePosition => $_getN(0);
  @$pb.TagNumber(1)
  set tilePosition(PackedTilePosition v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTilePosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearTilePosition() => clearField(1);
  @$pb.TagNumber(1)
  PackedTilePosition ensureTilePosition() => $_ensure(0);
}

class PackedTeleport extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedTeleport', createEmptyInstance: create)
    ..aOM<PackedPoint>(1, 'portA', protoName: 'portA', subBuilder: PackedPoint.create)
    ..aOM<PackedPoint>(2, 'portB', protoName: 'portB', subBuilder: PackedPoint.create)
    ..hasRequiredFields = false
  ;

  PackedTeleport._() : super();
  factory PackedTeleport() => create();
  factory PackedTeleport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedTeleport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedTeleport clone() => PackedTeleport()..mergeFromMessage(this);
  PackedTeleport copyWith(void Function(PackedTeleport) updates) => super.copyWith((message) => updates(message as PackedTeleport));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedTeleport create() => PackedTeleport._();
  PackedTeleport createEmptyInstance() => create();
  static $pb.PbList<PackedTeleport> createRepeated() => $pb.PbList<PackedTeleport>();
  @$core.pragma('dart2js:noInline')
  static PackedTeleport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedTeleport>(create);
  static PackedTeleport _defaultInstance;

  @$pb.TagNumber(1)
  PackedPoint get portA => $_getN(0);
  @$pb.TagNumber(1)
  set portA(PackedPoint v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPortA() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortA() => clearField(1);
  @$pb.TagNumber(1)
  PackedPoint ensurePortA() => $_ensure(0);

  @$pb.TagNumber(2)
  PackedPoint get portB => $_getN(1);
  @$pb.TagNumber(2)
  set portB(PackedPoint v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPortB() => $_has(1);
  @$pb.TagNumber(2)
  void clearPortB() => clearField(2);
  @$pb.TagNumber(2)
  PackedPoint ensurePortB() => $_ensure(1);
}

class PackedTilePosition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedTilePosition', createEmptyInstance: create)
    ..aOM<PackedPoint>(1, 'colRow', protoName: 'colRow', subBuilder: PackedPoint.create)
    ..aOM<PackedFractionalPoint>(2, 'relXY', protoName: 'relXY', subBuilder: PackedFractionalPoint.create)
    ..hasRequiredFields = false
  ;

  PackedTilePosition._() : super();
  factory PackedTilePosition() => create();
  factory PackedTilePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedTilePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedTilePosition clone() => PackedTilePosition()..mergeFromMessage(this);
  PackedTilePosition copyWith(void Function(PackedTilePosition) updates) => super.copyWith((message) => updates(message as PackedTilePosition));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedTilePosition create() => PackedTilePosition._();
  PackedTilePosition createEmptyInstance() => create();
  static $pb.PbList<PackedTilePosition> createRepeated() => $pb.PbList<PackedTilePosition>();
  @$core.pragma('dart2js:noInline')
  static PackedTilePosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedTilePosition>(create);
  static PackedTilePosition _defaultInstance;

  @$pb.TagNumber(1)
  PackedPoint get colRow => $_getN(0);
  @$pb.TagNumber(1)
  set colRow(PackedPoint v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasColRow() => $_has(0);
  @$pb.TagNumber(1)
  void clearColRow() => clearField(1);
  @$pb.TagNumber(1)
  PackedPoint ensureColRow() => $_ensure(0);

  @$pb.TagNumber(2)
  PackedFractionalPoint get relXY => $_getN(1);
  @$pb.TagNumber(2)
  set relXY(PackedFractionalPoint v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRelXY() => $_has(1);
  @$pb.TagNumber(2)
  void clearRelXY() => clearField(2);
  @$pb.TagNumber(2)
  PackedFractionalPoint ensureRelXY() => $_ensure(1);
}

class PackedFractionalPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedFractionalPoint', createEmptyInstance: create)
    ..a<$core.int>(1, 'xy', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  PackedFractionalPoint._() : super();
  factory PackedFractionalPoint() => create();
  factory PackedFractionalPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedFractionalPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedFractionalPoint clone() => PackedFractionalPoint()..mergeFromMessage(this);
  PackedFractionalPoint copyWith(void Function(PackedFractionalPoint) updates) => super.copyWith((message) => updates(message as PackedFractionalPoint));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedFractionalPoint create() => PackedFractionalPoint._();
  PackedFractionalPoint createEmptyInstance() => create();
  static $pb.PbList<PackedFractionalPoint> createRepeated() => $pb.PbList<PackedFractionalPoint>();
  @$core.pragma('dart2js:noInline')
  static PackedFractionalPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedFractionalPoint>(create);
  static PackedFractionalPoint _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get xy => $_getIZ(0);
  @$pb.TagNumber(1)
  set xy($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasXy() => $_has(0);
  @$pb.TagNumber(1)
  void clearXy() => clearField(1);
}

class PackedPoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedPoint', createEmptyInstance: create)
    ..a<$core.int>(1, 'xy', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  PackedPoint._() : super();
  factory PackedPoint() => create();
  factory PackedPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PackedPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PackedPoint clone() => PackedPoint()..mergeFromMessage(this);
  PackedPoint copyWith(void Function(PackedPoint) updates) => super.copyWith((message) => updates(message as PackedPoint));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PackedPoint create() => PackedPoint._();
  PackedPoint createEmptyInstance() => create();
  static $pb.PbList<PackedPoint> createRepeated() => $pb.PbList<PackedPoint>();
  @$core.pragma('dart2js:noInline')
  static PackedPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PackedPoint>(create);
  static PackedPoint _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get xy => $_getIZ(0);
  @$pb.TagNumber(1)
  set xy($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasXy() => $_has(0);
  @$pb.TagNumber(1)
  void clearXy() => clearField(1);
}

class DoubleTwoDecimals extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DoubleTwoDecimals', createEmptyInstance: create)
    ..a<$core.int>(1, 'value', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DoubleTwoDecimals._() : super();
  factory DoubleTwoDecimals() => create();
  factory DoubleTwoDecimals.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DoubleTwoDecimals.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DoubleTwoDecimals clone() => DoubleTwoDecimals()..mergeFromMessage(this);
  DoubleTwoDecimals copyWith(void Function(DoubleTwoDecimals) updates) => super.copyWith((message) => updates(message as DoubleTwoDecimals));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DoubleTwoDecimals create() => DoubleTwoDecimals._();
  DoubleTwoDecimals createEmptyInstance() => create();
  static $pb.PbList<DoubleTwoDecimals> createRepeated() => $pb.PbList<DoubleTwoDecimals>();
  @$core.pragma('dart2js:noInline')
  static DoubleTwoDecimals getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DoubleTwoDecimals>(create);
  static DoubleTwoDecimals _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

class DoubleFourDecimals extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DoubleFourDecimals', createEmptyInstance: create)
    ..a<$core.int>(1, 'value', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  DoubleFourDecimals._() : super();
  factory DoubleFourDecimals() => create();
  factory DoubleFourDecimals.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DoubleFourDecimals.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  DoubleFourDecimals clone() => DoubleFourDecimals()..mergeFromMessage(this);
  DoubleFourDecimals copyWith(void Function(DoubleFourDecimals) updates) => super.copyWith((message) => updates(message as DoubleFourDecimals));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DoubleFourDecimals create() => DoubleFourDecimals._();
  DoubleFourDecimals createEmptyInstance() => create();
  static $pb.PbList<DoubleFourDecimals> createRepeated() => $pb.PbList<DoubleFourDecimals>();
  @$core.pragma('dart2js:noInline')
  static DoubleFourDecimals getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DoubleFourDecimals>(create);
  static DoubleFourDecimals _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
}

