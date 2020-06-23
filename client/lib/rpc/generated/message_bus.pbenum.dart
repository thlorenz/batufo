///
//  Generated code. Do not modify.
//  source: message_bus.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Platform extends $pb.ProtobufEnum {
  static const Platform MacOS = Platform._(0, 'MacOS');
  static const Platform Android = Platform._(1, 'Android');
  static const Platform Linux = Platform._(2, 'Linux');
  static const Platform Windows = Platform._(3, 'Windows');
  static const Platform IOS = Platform._(4, 'IOS');
  static const Platform Fuchsia = Platform._(5, 'Fuchsia');
  static const Platform Web = Platform._(6, 'Web');

  static const $core.List<Platform> values = <Platform> [
    MacOS,
    Android,
    Linux,
    Windows,
    IOS,
    Fuchsia,
    Web,
  ];

  static final $core.Map<$core.int, Platform> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Platform valueOf($core.int value) => _byValue[value];

  const Platform._($core.int v, $core.String n) : super(v, n);
}

class PackedPickupType extends $pb.ProtobufEnum {
  static const PackedPickupType Medkit = PackedPickupType._(0, 'Medkit');
  static const PackedPickupType Shield = PackedPickupType._(1, 'Shield');
  static const PackedPickupType Bomb = PackedPickupType._(2, 'Bomb');

  static const $core.List<PackedPickupType> values = <PackedPickupType> [
    Medkit,
    Shield,
    Bomb,
  ];

  static final $core.Map<$core.int, PackedPickupType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PackedPickupType valueOf($core.int value) => _byValue[value];

  const PackedPickupType._($core.int v, $core.String n) : super(v, n);
}

