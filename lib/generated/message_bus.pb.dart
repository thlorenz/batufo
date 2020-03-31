///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Empty', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Empty clone() => Empty()..mergeFromMessage(this);
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty _defaultInstance;
}

class PlayingClient extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlayingClient', createEmptyInstance: create)
    ..a<$core.int>(1, 'gameID', $pb.PbFieldType.OU3, protoName: 'gameID')
    ..a<$core.int>(2, 'clientID', $pb.PbFieldType.OU3, protoName: 'clientID')
    ..hasRequiredFields = false
  ;

  PlayingClient._() : super();
  factory PlayingClient() => create();
  factory PlayingClient.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayingClient.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlayingClient clone() => PlayingClient()..mergeFromMessage(this);
  PlayingClient copyWith(void Function(PlayingClient) updates) => super.copyWith((message) => updates(message as PlayingClient));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayingClient create() => PlayingClient._();
  PlayingClient createEmptyInstance() => create();
  static $pb.PbList<PlayingClient> createRepeated() => $pb.PbList<PlayingClient>();
  @$core.pragma('dart2js:noInline')
  static PlayingClient getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayingClient>(create);
  static PlayingClient _defaultInstance;

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
}

class PackedPlayerModel extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PackedPlayerModel', createEmptyInstance: create)
    ..aOM<PackedTilePosition>(1, 'tilePosition', protoName: 'tilePosition', subBuilder: PackedTilePosition.create)
    ..aOM<PackedFractionalPoint>(2, 'velocity', subBuilder: PackedFractionalPoint.create)
    ..aOM<DoubleFourDecimals>(3, 'angle', subBuilder: DoubleFourDecimals.create)
    ..a<$core.int>(4, 'flags', $pb.PbFieldType.OU3)
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
  PackedTilePosition get tilePosition => $_getN(0);
  @$pb.TagNumber(1)
  set tilePosition(PackedTilePosition v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTilePosition() => $_has(0);
  @$pb.TagNumber(1)
  void clearTilePosition() => clearField(1);
  @$pb.TagNumber(1)
  PackedTilePosition ensureTilePosition() => $_ensure(0);

  @$pb.TagNumber(2)
  PackedFractionalPoint get velocity => $_getN(1);
  @$pb.TagNumber(2)
  set velocity(PackedFractionalPoint v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasVelocity() => $_has(1);
  @$pb.TagNumber(2)
  void clearVelocity() => clearField(2);
  @$pb.TagNumber(2)
  PackedFractionalPoint ensureVelocity() => $_ensure(1);

  @$pb.TagNumber(3)
  DoubleFourDecimals get angle => $_getN(2);
  @$pb.TagNumber(3)
  set angle(DoubleFourDecimals v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAngle() => $_has(2);
  @$pb.TagNumber(3)
  void clearAngle() => clearField(3);
  @$pb.TagNumber(3)
  DoubleFourDecimals ensureAngle() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get flags => $_getIZ(3);
  @$pb.TagNumber(4)
  set flags($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFlags() => $_has(3);
  @$pb.TagNumber(4)
  void clearFlags() => clearField(4);
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

