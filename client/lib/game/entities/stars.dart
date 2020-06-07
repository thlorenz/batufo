import 'dart:ui' show Canvas, Paint, Picture, PictureRecorder;

import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors, PaintingStyle, Size;

class Star {
  final TilePosition tilePosition;
  final double radius;
  const Star(this.tilePosition, this.radius);
}

class Stars {
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
  final bool enableRecording;

  Picture _recordedPicture;

  Stars(
    this._tileSize, {
    @required this.lerpFactor,
    @required this.enableRecording,
    @required this.minRadius,
    @required this.maxRadius,
    @required this.density,
  })  : _starPaint = Paint()
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill,
        _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2;

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

  Picture _recordPicture(Size size) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    for (final star in _stars) _renderStar(canvas, star);
    return recorder.endRecording();
  }

  void resize(Size size) {
    if (density == 0) return;
    final fullWidth = size.width * lerpFactor;
    final fullHeight = size.height * lerpFactor;
    final fullSize = Size(fullWidth, fullHeight);
    _initStars(fullSize);
    if (enableRecording) _recordedPicture = _recordPicture(fullSize);
  }

  void render(Canvas canvas, Size size) {
    if (density == 0) return;
    if (enableRecording) {
      canvas.drawPicture(_recordedPicture);
    } else {
      for (final star in _stars) _renderStar(canvas, star);
    }
  }
}
