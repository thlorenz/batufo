import 'dart:ui' show Canvas, Offset, Paint, Rect;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/entities/scene.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle, Size;

class Star {
  final TilePosition tilePosition;
  final Offset worldPosition;
  final double radius;
  const Star(this.tilePosition, this.worldPosition, this.radius);
}

final Paint _debugVisibleRectPaint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.stroke
  ..strokeWidth = 4.0;

class Stars extends Scene {
  final double lerpFactor;
  final int density;
  final double _tileSize;
  final double _tileRangeMin;
  final double _tileRangeMax;
  final Paint _starPaint;
  final List<Star> _stars;
  final double minRadius;
  final double maxRadius;
  final bool debugVisibleRect;
  final RandomNumber _rnd;
  final bool _skipRender;

  // rows x cols
  final List<List<bool>> coveredTiles;

  int _tiledx;
  int _tiledy;

  Stars(
    this._tileSize, {
    @required this.lerpFactor,
    @required bool enableRecording,
    @required this.minRadius,
    @required this.maxRadius,
    @required this.density,
    @required this.coveredTiles,
    this.debugVisibleRect = false,
  })  : _starPaint = Paint()
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill,
        _stars = [],
        _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2,
        _skipRender = density <= 0,
        _tiledx = 0,
        _tiledy = 0,
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
    final worldOffset = tp.toWorldOffset();
    final star = Star(tp, worldOffset, radius);
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

  bool _coversColRow(int col, int row) {
    if (0 > row || row >= coveredTiles.length || 0 > col) return false;
    final cols = coveredTiles[row];
    if (col >= cols.length) return false;
    return cols[col];
  }

  bool _covered(TilePosition tp) {
    final row = tp.row + _tiledy;
    final col = tp.col + _tiledx;
    return _coversColRow(col, row) &&
        _coversColRow(col, row + 1) &&
        _coversColRow(col, row - 1) &&
        _coversColRow(col + 1, row) &&
        _coversColRow(col - 1, row);
  }

  void _renderStar(
    Canvas canvas,
    Rect visibleRect,
    Star star,
  ) {
    if (!_covered(star.tilePosition) &&
        visibleRect.contains(star.worldPosition)) {
      // bottleneck
      canvas.drawCircle(star.worldPosition, star.radius, _starPaint);
    }
  }

  void updateOffset(Offset offset) {
    _tiledx = (offset.dx / _tileSize).floor();
    _tiledy = (offset.dy / _tileSize).floor();
  }

  void resizeScene(Size fullSize) {
    _initStars(fullSize);
  }

  void renderScene(
    Canvas canvas,
    Rect visibleRect,
    Size size,
  ) {
    for (final star in _stars) {
      _renderStar(canvas, visibleRect, star);
    }
    if (debugVisibleRect) {
      canvas.drawRect(visibleRect, _debugVisibleRectPaint);
    }
  }
}
