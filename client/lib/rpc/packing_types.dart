import 'package:batufo/rpc/generated/message_bus.pb.dart';

class Point {
  final int x;
  final int y;

  // 0000 0000 0000 0000 1111 1111 1111 1111
  static const mask = 0xffff;
  static const shift = 16;

  const Point(this.x, this.y);

  PackedPoint pack() {
    final xy = x << shift | y;
    return PackedPoint()..xy = xy;
  }

  factory Point.unpack(PackedPoint data) {
    final xy = data.xy;
    final y = xy & mask;
    final x = xy >> shift;
    return Point(x, y);
  }

  @override
  String toString() {
    return 'Point { x: $x, y: $y }';
  }
}

int _doubleToInt(double value, int factor) => (value * factor).floor();

DoubleTwoDecimals packTwoDecimals(double value) {
  return DoubleTwoDecimals()..value = _doubleToInt(value, 100);
}

DoubleFourDecimals packFourDecimals(double value) {
  return DoubleFourDecimals()..value = _doubleToInt(value, 10000);
}

double unpackTwoDecimals(DoubleTwoDecimals data) {
  return data.value / 1E2;
}

double unpackFourDecimals(DoubleFourDecimals data) {
  return data.value / 1E4;
}

///
/// The max doubles for x/y that can be packed is +-32767
class FractionalPoint {
  final double x;
  final double y;

  static const mask = 0xffff;
  static const signMask = 0x8000;
  static const unsignMask = 0x7FFF;

  static const factor = 100;

  const FractionalPoint(this.x, this.y);

  PackedFractionalPoint pack({int factor = FractionalPoint.factor}) {
    final sintX = (x * factor).floor();
    final sintY = (y * factor).floor();

    final signX = sintX < 0 ? signMask : 0;
    final signY = sintY < 0 ? signMask : 0;
    final intX = sintX.abs() | signX;
    final intY = sintY.abs() | signY;
    final xy = intX << 16 | intY;
    return PackedFractionalPoint()..xy = xy;
  }

  factory FractionalPoint.unpack(
    PackedFractionalPoint data, {
    int factor = FractionalPoint.factor,
  }) {
    final xy = data.xy;
    final intY = xy & mask;
    final intX = xy >> 16;
    final xSigned = (intX & signMask) > 0;
    final ySigned = (intY & signMask) > 0;
    final x = xSigned ? -(intX & unsignMask) : intX;
    final y = ySigned ? -(intY & unsignMask) : intY;
    return FractionalPoint(x / factor, y / factor);
  }

  String toString() {
    return 'FractionalPoint{x: $x, y: $y}';
  }
}
