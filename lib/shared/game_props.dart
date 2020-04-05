class GameProps {
  static const tileSize = 40.0;

  static const gesturePlayerRotationFactor = 0.04;
  static const gesturePlayerThrustFactor = 0.002;
  static const gesturePlayerMinThrustDelta = 2.2;

  static const keyboardPlayerRotationFactor = 0.004;
  static const keyboardPlayerThrustForce = 0.0005; // Newton

  // TODO(thlorenz): need to take those into account for above
  // thrust force value
  static const playerMass = 4000.0; // kg
  static const playerThrustAcceleration =
      keyboardPlayerThrustForce / playerMass; // m/s2
  static const playerHitsWallSlowdown = 0.7;
  static const playerSize = tileSize * 0.75;
  static const playerTotalHealth = 100.0;

  static const playerHitsWallHealthFactor = 0.5;

  static const playerThrustAnimationDurationMs = 200.0;

  static const bulletForce = 0.4;
  static const bulletMsToExplode = 200.0;

  static bool get debugPlayerHitTile => false;

  static bool get renderBackground => true;
}
