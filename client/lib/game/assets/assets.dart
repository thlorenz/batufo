import 'package:batufo/game/assets/audio_asset.dart';
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
  final ImageAsset planets = ImageAsset(
    'assets/images/bg/planets.png',
    2560,
    320,
    rows: 1,
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
  final ImageAsset skull = ImageAsset(
    'assets/images/sprites/skull.png',
    840,
    859,
    rows: 1,
    cols: 1,
  );
  final ImageAsset medkit = ImageAsset(
    'assets/images/sprites/medkit.png',
    188,
    188,
    rows: 1,
    cols: 1,
  );
  final ImageAsset shield = ImageAsset(
    'assets/images/sprites/shield.png',
    188,
    188,
    rows: 1,
    cols: 1,
  );
  final ImageAsset bomb = ImageAsset(
    'assets/images/sprites/bomb.png',
    188,
    188,
    rows: 1,
    cols: 1,
  );
  final ImageAsset circleRed = ImageAsset(
    'assets/images/sprites/circle.red.png',
    186,
    186,
    rows: 1,
    cols: 1,
  );

  final AudioAsset audioThrust = AudioAsset('audio/thrust.wav');
  final AudioAsset audioBullet = AudioAsset('audio/bullet.wav');
  final AudioAsset audioBulletExploded =
      AudioAsset('audio/bullet-exploded.wav');
  final AudioAsset audioPlayerHitWall = AudioAsset('audio/player-hit-wall.wav');
  final AudioAsset audioPickupMedkit = AudioAsset('audio/pickup-medkit.wav');
  final AudioAsset audioPickupShield = AudioAsset('audio/pickup-shield.wav');
  final AudioAsset audioPickupBomb = AudioAsset('audio/pickup-bomb.wav');
  final AudioAsset audioBombExploding = AudioAsset('audio/bomb-exploding.wav');
  final AudioAsset audioSwitchWeapon = AudioAsset('audio/switch-weapon.wav');
  final AudioAsset audioTeleport = AudioAsset('audio/teleport.wav');
}

final _Assets assets = _Assets();

final Map<String, AudioAsset> audioAssets = {
  'thrust': assets.audioThrust,
  'bullet': assets.audioBullet,
  'bullet-exploded': assets.audioBulletExploded,
  'bomb-exploding': assets.audioBombExploding,
  'player-hit-wall': assets.audioPlayerHitWall,
  'pickup-medkit': assets.audioPickupMedkit,
  'pickup-shield': assets.audioPickupShield,
  'pickup-bomb': assets.audioPickupBomb,
  'switch-weapon': assets.audioSwitchWeapon,
  'teleport': assets.audioTeleport,
};
