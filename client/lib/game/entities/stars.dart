import 'dart:ui' show Canvas, Paint, Picture, PictureRecorder;

import 'package:batufo/arena/arena.dart';
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
  final double _oversizeFactor;
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
    Arena arena,
    this._oversizeFactor, {
    @required this.enableRecording,
    @required this.minRadius,
    @required this.maxRadius,
    @required this.density,
  })  : _tileSize = arena.tileSize.toDouble(),
        _starPaint = Paint()
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill,
        _rnd = RandomNumber(),
        _tileRangeMin = -(arena.tileSize / 2),
        _tileRangeMax = arena.tileSize / 2;

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

  void _initStars(Size size) {
    final ncols = size.width ~/ _tileSize;
    final nrows = size.height ~/ _tileSize;
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
  }

  void _renderStar(Canvas canvas, Star star) {
    final worldOffset = star.tilePosition.toWorldOffset();
    canvas.drawCircle(worldOffset, star.radius, _starPaint);
  }

  Picture _recordPicture(Size size) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    // TODO: why is this necessary? Related to oversizeFactor
    canvas.translate(-(size.width / 8), -(size.height / 4));

    canvas.translate(size.width / 2, size.height / 2);
    for (final star in _stars) _renderStar(canvas, star);
    return recorder.endRecording();
  }

  void resize(Size size) {
    final fullWidth = size.width * _oversizeFactor;
    final fullHeight = size.height * _oversizeFactor;
    final fullSize = Size(fullWidth, fullHeight);
    _initStars(fullSize);
    if (enableRecording) _recordedPicture = _recordPicture(fullSize);
  }

  void render(Canvas canvas, Size size) {
    if (enableRecording) {
      canvas.drawPicture(_recordedPicture);
    } else {
      canvas.translate(size.width / 2, size.height / 2);
      for (final star in _stars) _renderStar(canvas, star);
    }
  }
}
