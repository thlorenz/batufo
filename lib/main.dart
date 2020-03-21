import 'package:batufo/engine/images.dart';
import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/levels/levels.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/create_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Images.instance.loadAll(['assets/images/sprites/player.png']);

  final playerSprite = await Sprite.fromPath(
    'assets/images/sprites/player.png',
    width: GameProps.tileSize,
    height: GameProps.tileSize,
  );

  final tilemap = Tilemap.build(Levels.simple);
  debugPrint('$tilemap');
  WorldPosition.tileSize = GameProps.tileSize;
  final gameModel = createModel(tilemap, GameProps.tileSize);
  debugPrint('$gameModel');
  runApp(MyApp(gameModel: gameModel, playerSprite: playerSprite));
}

class MyApp extends StatelessWidget {
  final Sprite playerSprite;
  final GameModel gameModel;
  MyApp({@required this.gameModel, @required this.playerSprite});

  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: CanvasPainter(
          gameModel: gameModel,
          playerSprite: playerSprite,
        ),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final Paint _circlePaint;
  final Paint _gridPaint;
  final Sprite playerSprite;
  final GameModel gameModel;
  CanvasPainter({
    @required this.gameModel,
    @required this.playerSprite,
  })  : _circlePaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
        _gridPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.2;

  void paint(Canvas canvas, Size size) {
    _lowerLeftCanvas(canvas, size.height);
    _drawGrid(canvas, size);
    _drawPlayer(canvas);
  }

  void _drawPlayer(Canvas canvas) {
    final player = gameModel.player;
    final playerTilePosition = player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(player.angle);
    playerSprite.render(canvas, Offset.zero);
    canvas.drawCircle(Offset.zero, 5, _circlePaint);
    canvas.restore();
  }

  void _lowerLeftCanvas(Canvas canvas, double height) {
    canvas.translate(0, height);
    canvas.scale(1, -1);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final delta = GameProps.tileSize;
    for (double col = 0.0; col < size.width; col += delta) {
      canvas.drawLine(Offset(col, 0), Offset(col, size.height), _gridPaint);
    }
    for (double row = 0.0; row < size.height; row += delta) {
      canvas.drawLine(Offset(0, row), Offset(size.width, row), _gridPaint);
    }
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
