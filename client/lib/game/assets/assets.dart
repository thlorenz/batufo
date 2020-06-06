import 'package:batufo/game/assets/image_asset.dart';

class _Assets {
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
  final ImageAsset planet1 = ImageAsset(
    'assets/images/bg/planet1.png',
    160,
    160,
  );
  final ImageAsset planet2 = ImageAsset(
    'assets/images/bg/planet2.png',
    160,
    160,
  );
  final ImageAsset planet3 = ImageAsset(
    'assets/images/bg/planet3.png',
    160,
    160,
  );
  final ImageAsset planet4 = ImageAsset(
    'assets/images/bg/planet4.png',
    160,
    160,
  );
  final ImageAsset planet5 = ImageAsset(
    'assets/images/bg/planet5.png',
    160,
    160,
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
  final ImageAsset skull = ImageAsset(
    'assets/images/sprites/skull.png',
    840,
    859,
    rows: 1,
    cols: 1,
  );
}

final _Assets assets = _Assets();
