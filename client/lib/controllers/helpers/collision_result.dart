import 'dart:ui' show Offset;

class CollisionResult {
  final bool collided;
  final Offset velocity;
  final double force;

  CollisionResult(this.collided, this.velocity, this.force);
}
