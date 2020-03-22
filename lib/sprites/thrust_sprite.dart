import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/game_props.dart';

class ThrustSprite {
  static ImageAsset asset = GameProps.assets.thrust;
  final SpriteSheet _spriteSheet;
  ThrustSprite() : _spriteSheet = SpriteSheet.fromImageAsset(asset);
}
