import 'dart:ui' show Canvas, Offset;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/models/player_model.dart';

class Player {
  Sprite playerSprite;
  Player(String imagePath, {double tileSize}) {
    playerSprite = Sprite(imagePath, width: tileSize, height: tileSize);
  }

  PlayerModel update(double dt, PlayerModel model) {
    model.angle += dt / 1E3;
    return model;
  }

  void render(Canvas canvas, PlayerModel player) {
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(player.angle);
    playerSprite.render(canvas, Offset.zero);
    canvas.restore();
  }
}
