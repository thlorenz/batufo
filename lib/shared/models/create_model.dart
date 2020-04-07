import 'package:batufo/shared/arena/arena.dart';
import 'package:batufo/shared/models/bullet_model.dart';
import 'package:batufo/shared/models/game_model.dart';

GameModel createModel(Arena arena, int clientID) {
  final bullets = <BulletModel>[];
  return GameModel(
    bullets: bullets,
  );
}
