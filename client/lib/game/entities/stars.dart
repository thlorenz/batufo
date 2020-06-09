import 'dart:ui' show Canvas, Paint;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/scene.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle, Size;

class Star {
  final TilePosition tilePosition;
  final double radius;
  const Star(this.tilePosition, this.radius);
}

class Stars extends Scene {
  final double lerpFactor;
  final int density;
  final double _tileSize;
  final double _tileRangeMin;
  final double _tileRangeMax;
  final Paint _starPaint;
  final List<Star> _stars = [];
  final double minRadius;
  final double maxRadius;
  final RandomNumber _rnd;
  final bool _skipRender;

  Stars(
    this._tileSize, {
    @required this.lerpFactor,
    @required bool enableRecording,
    @required this.minRadius,
    @required this.maxRadius,
    @required this.density,
  })  : _starPaint = Paint()
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill,
        _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2,
        _skipRender = density <= 0,
        super(enableRecording: enableRecording, sizeFactor: lerpFactor);

  bool get skipRender => _skipRender;

  int _howManyStars() {
    const clustering = 1;
    return _rnd.nextInt(-(density * clustering), density * clustering);
  }

  void _addStar(int col, int row) {
    final dx = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final dy = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final tp = TilePosition(col, row, dx, dy);
    final radius = _rnd.nextDouble(minRadius, maxRadius);
    final star = Star(tp, radius);
    _stars.add(star);
  }

  void _initStars(Size size) {
    final ncols = size.width ~/ _tileSize + 1;
    final nrows = size.height ~/ _tileSize + 1;
    _stars.clear();

    for (int row = 0; row < nrows; row++) {
      for (int col = 0; col < ncols; col++) {
        final nstars = _howManyStars();
        if (nstars <= 0) continue;
        for (int n = 0; n < nstars; n++) {
          _addStar(col, row);
        }
      }
    }
  }

  void _renderStar(Canvas canvas, Star star) {
    final worldOffset = star.tilePosition.toWorldOffset();
    canvas.drawCircle(worldOffset, star.radius, _starPaint);
  }

  void resizeScene(Size fullSize) {
    _initStars(fullSize);
  }

  void renderScene(Canvas canvas, Size size) {
    for (final star in _stars) _renderStar(canvas, star);
  }
}
