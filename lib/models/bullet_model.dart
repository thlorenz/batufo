import 'package:batufo/dart_types/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/tile_position.dart';

class BulletModel {
  TilePosition tilePosition;
  Offset velocity;
  bool collided;

  BulletModel({
    @required this.tilePosition,
    @required this.velocity,
    this.collided = false,
  });

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
     velocity: $velocity
   }''';
  }
}
