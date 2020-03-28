import 'package:batufo/dart_types.dart';
import 'package:batufo/engine/geometry/dart_geometry.dart' show Offset;
import 'package:batufo/engine/tile_position.dart';

class PlayerModel {
  TilePosition tilePosition;
  Offset velocity;
  double angle;
  bool appliedThrust;
  PlayerModel({
    @required this.tilePosition,
    @required this.angle,
    @required this.velocity,
    @required this.appliedThrust,
  });

  String toString() {
    return '''PlayerModel {
     tilePosition: $tilePosition
     angle: $angle
     velocity: $velocity
     appliedThrust: $appliedThrust
   }''';
  }
}
