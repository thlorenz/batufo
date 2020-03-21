import 'package:batufo/engine/world_position.dart';
import 'package:batufo/game_props.dart';
import 'package:batufo/levels/levels.dart';
import 'package:batufo/levels/tilemap.dart';
import 'package:batufo/models/create_model.dart';
import 'package:batufo/models/game_model.dart';
import 'package:flutter/material.dart';

void main() {
  final tilemap = Tilemap.build(Levels.simple);
  debugPrint('$tilemap');
  WorldPosition.tileSize = GameProps.tileSize;
  final gameModel = createModel(tilemap, GameProps.tileSize);
  debugPrint('$gameModel');
  runApp(MyApp(gameModel: gameModel));
}

class MyApp extends StatelessWidget {
  final GameModel gameModel;
  MyApp({this.gameModel});

  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: CanvasPainter(gameModel: gameModel),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final Paint _circlePaint;
  final Paint _gridPaint;
  final GameModel gameModel;
  CanvasPainter({@required this.gameModel})
      : _circlePaint = Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill,
        _gridPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.2;

  void paint(Canvas canvas, Size size) {
    _lowerLeftCanvas(canvas, size.height);
    _drawGrid(canvas, size);
    final radius = 10.0;
    final playerTilePosition = gameModel.player.tilePosition;
    final center = WorldPosition.fromTilePosition(playerTilePosition);
    canvas.drawCircle(center.toOffset(), radius, _circlePaint);
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
