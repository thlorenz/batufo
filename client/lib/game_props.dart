const PORT = 2222;

class GameProps {
  static const gesturePlayerRotationFactor = 0.04;
  static const gesturePlayerMinThrustDelta = 2.2;

  static const keyboardPlayerRotationFactor = 0.004;
  static const playerThrustForce = 0.07; // Newton

  // TODO(thlorenz): need to take those into account for above
  // thrust force value
  static const playerMass = 4000.0; // kg
  static const playerThrustAcceleration =
      playerThrustForce / playerMass; // m/s2
  static const playerHitsWallSlowdown = 0.3;
  static const playerSizeFactor = 0.75;
  static const playerTotalHealth = 100.0;

  static const playerHitsWallHealthFactor = 50.0;
  static const bulletHitsPlayerHealthToll = playerTotalHealth / 20;

  static const playerThrustAnimationDurationMs = 200.0;

  static const bulletForce = 0.4;
  static const bulletMsToExplode = 200.0;

  static bool get debugPlayerHitTile => false;
  static bool get debugWallHitTile => false;
  static bool get debugGrid => false;

  static bool get renderBackground => true;

  static const GAME_ID = 'gameid';
  static const CLIENT_ID = 'clientid';

  static const playerInputSyncIntervalMs = 50.0;
  static const timeBetweenThrustsMs = 500.0;
  static const timeBetweenBulletsMs = 250.0;

  static const scoreOnHit = 100;
  static const scoreOnKill = 500;

  static const backgroundOversizeFactor = 4;

  static const localhost = 'http://localhost:$PORT';
  static const localbox = 'http://192.168.1.7:$PORT';
  static const cloudbox = 'https://batufo-game.appspot.com';
}
