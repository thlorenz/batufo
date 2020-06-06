import 'dart:ui' show Canvas, Paint, Rect, Size;

import 'package:batufo/engine/images.dart' show Images;
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/game/assets/image_asset.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/material.dart';

final Paint _paint = Paint()..color = Colors.white;

class Planet {
  final TilePosition tilePosition;
  final ImageAsset imageAsset;
  final double radius;
  const Planet(this.tilePosition, this.imageAsset, this.radius);
}

final _planetAssets = [
  assets.planet1,
  assets.planet2,
  assets.planet3,
  assets.planet4,
  assets.planet5,
];

class Planets {
  final int _oversizeFactor;
  final int density;
  final double _tileSize;
  final double _tileRangeMin;
  final double _tileRangeMax;
  final double minRadius;
  final double maxRadius;
  final List<Planet> _planets = [];
  final RandomNumber _rnd;

  bool needsRegenerate = true;

  Planets(
    this._tileSize,
    this._oversizeFactor, {
    this.minRadius = 0.1,
    this.maxRadius = 0.4,
    @required this.density,
  })  : _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2;

  ImageAsset _randomPlanetImage() {
    // purposely generating a number too large most of the time which means we
    // won't draw a planet
    final idx = _rnd.nextInt(0, 10000 ~/ density);
    return idx >= _planetAssets.length ? null : _planetAssets[idx];
  }

  void _addPlanet(int col, int row) {
    final imageAsset = _randomPlanetImage();
    if (imageAsset == null) return;
    final dx = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final dy = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final tp = TilePosition(col, row, dx, dy);
    final radiusFactor = _rnd.nextDouble(minRadius, maxRadius);
    final planet = Planet(tp, imageAsset, radiusFactor * imageAsset.width);
    _planets.add(planet);
  }

  void _initPlanets(int ncols, int nrows) {
    if (!needsRegenerate) return;
    _planets.clear();
    final xmax = ncols ~/ 2;
    final xmin = -xmax;
    final ymax = nrows ~/ 2;
    final ymin = -ymax;
    for (int row = ymin; row < ymax; row++) {
      for (int col = xmin; col < xmax; col++) {
        _addPlanet(col, row);
      }
    }
    needsRegenerate = false;
  }

  void _renderPlanet(Canvas canvas, Planet planet) {
    final worldOffset = planet.tilePosition.toWorldOffset();
    final img = Images.instance.getImage(planet.imageAsset.imagePath);
    final src = Rect.fromLTWH(
      0,
      0,
      img.width.toDouble(),
      img.height.toDouble(),
    );
    final dst = Rect.fromCircle(center: worldOffset, radius: planet.radius);
    canvas.drawImageRect(img, src, dst, _paint);
  }

  void render(Canvas canvas, Size size) {
    _initPlanets(
      size.width ~/ _tileSize * _oversizeFactor,
      size.height ~/ _tileSize * _oversizeFactor,
    );
    for (final planet in _planets) _renderPlanet(canvas, planet);
  }
}
