class GameProps {
  static const tileSize = 40.0;

  static const gesturePlayerRotationFactor = 0.04;
  static const gesturePlayerMinThrustDelta = 2.2;

  static const keyboardPlayerRotationFactor = 0.004;
  static const playerThrustForce = 0.05; // Newton

  // TODO(thlorenz): need to take those into account for above
  // thrust force value
  static const playerMass = 4000.0; // kg
  static const playerThrustAcceleration =
      playerThrustForce / playerMass; // m/s2
  static const playerHitsWallSlowdown = 0.7;
  static const playerSize = tileSize * 0.75;
  static const playerTotalHealth = 100.0;

  static const playerHitsWallHealthFactor = 50.0;
  static const bulletHitsPlayerHealthToll = playerTotalHealth / 5;

  static const playerThrustAnimationDurationMs = 200.0;

  static const bulletForce = 0.4;
  static const bulletMsToExplode = 200.0;

  static bool get debugPlayerHitTile => false;

  static bool get renderBackground => true;

  static const GAME_ID = 'gameid';
  static const CLIENT_ID = 'clientid';

  static const playerInputSyncIntervalMs = 50.0;
  static const timeBetweenThrustsMs = 500.0;
  static const timeBetweenBulletsMs = 250.0;
}
