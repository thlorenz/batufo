class ImageAsset {
  final String imagePath;
  final int width;
  final int height;
  final int cols;
  final int rows;

  ImageAsset(
    this.imagePath,
    this.width,
    this.height, {
    this.cols = 1,
    this.rows = 1,
  });
}

class Assets {
  final ImageAsset player =
      ImageAsset('assets/images/sprites/player.png', 536, 534);
  final ImageAsset thrust = ImageAsset(
    'assets/images/sprites/thrust.png',
    7700,
    442,
    rows: 1,
    cols: 50,
  );
  final ImageAsset floorTiles = ImageAsset(
    'assets/images/bg/floor-tiles.png',
    1024,
    1024,
    rows: 8,
    cols: 8,
  );
  final ImageAsset wallMetal = ImageAsset(
    'assets/images/static/wall-metal.png',
    66,
    66,
    rows: 1,
    cols: 1,
  );

  final ImageAsset bulletExplosion = ImageAsset(
    'assets/images/sprites/bullet-explosion.png',
    256,
    256,
    rows: 4,
    cols: 4,
  );
}

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

  static Assets get assets => Assets();
}
