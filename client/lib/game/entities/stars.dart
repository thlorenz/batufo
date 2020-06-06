import 'dart:ui' show Canvas, Paint;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle, Rect, Size;

class Star {
  final TilePosition tilePosition;
  final double radius;
  const Star(this.tilePosition, this.radius);
}

class Stars {
  final int _oversizeFactor;
  final int density;
  final double _tileSize;
  final double _tileRangeMin;
  final double _tileRangeMax;
  final Paint _starPaint;
  final Paint _backgroundPaint;
  final List<Star> _stars = [];
  final double minRadius;
  final double maxRadius;
  final RandomNumber _rnd;

  bool needsRegenerate = true;

  Stars(
    this._tileSize,
    this._oversizeFactor, {
    this.minRadius = 0.1,
    this.maxRadius = 0.4,
    @required this.density,
  })  : _starPaint = Paint()
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill,
        _backgroundPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill,
        _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2;

  int _howManyStars() {
    return _rnd.nextInt(0, density);
  }

  void _addStar(int col, int row) {
    final dx = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final dy = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final tp = TilePosition(col, row, dx, dy);
    final radius = _rnd.nextDouble(minRadius, maxRadius);
    final star = Star(tp, radius);
    _stars.add(star);
  }

  void _initStars(int ncols, int nrows) {
    if (!needsRegenerate) return;
    _stars.clear();
    final xmax = ncols ~/ 2;
    final xmin = -xmax;
    final ymax = nrows ~/ 2;
    final ymin = -ymax;
    for (int row = ymin; row < ymax; row++) {
      for (int col = xmin; col < xmax; col++) {
        for (int n = 0; n < _howManyStars(); n++) {
          _addStar(col, row);
        }
      }
    }
    needsRegenerate = false;
  }

  void _renderStar(Canvas canvas, Star star) {
    final worldOffset = star.tilePosition.toWorldOffset();
    canvas.drawCircle(worldOffset, star.radius, _starPaint);
  }

  void renderBackground(
    Canvas canvas,
    Size size,
  ) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _backgroundPaint,
    );
  }

  void render(Canvas canvas, Size size) {
    _initStars(
      size.width ~/ _tileSize * _oversizeFactor,
      size.height ~/ _tileSize * _oversizeFactor,
    );
    for (final star in _stars) _renderStar(canvas, star);
  }
}
