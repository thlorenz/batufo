import 'dart:ui' show Canvas, Rect, Size;

import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/sprite_sheet.dart';
import 'package:batufo/engine/tile_position.dart';
import 'package:batufo/game/assets/assets.dart';
import 'package:batufo/util/math.dart';
import 'package:flutter/material.dart';

class Planet {
  final TilePosition tilePosition;
  final Sprite sprite;
  final double radius;
  const Planet(this.tilePosition, this.sprite, this.radius);
}

class Planets {
  final double _oversizeFactor;
  final int density;
  final double _tileSize;
  final double _tileRangeMin;
  final double _tileRangeMax;
  final double minRadius;
  final double maxRadius;
  final List<Planet> _planets = [];
  final RandomNumber _rnd;
  final SpriteSheet planets;

  bool needsRegenerate = true;

  Planets(
    this._tileSize,
    this._oversizeFactor, {
    this.minRadius = 0.1,
    this.maxRadius = 0.4,
    @required this.density,
  })  : _rnd = RandomNumber(),
        _tileRangeMin = -(_tileSize / 2),
        _tileRangeMax = _tileSize / 2,
        planets = SpriteSheet.fromImageAsset(assets.planets);

  Sprite _randomPlanetSprite() {
    // purposely generating a number too large most of the time which means we
    // won't draw a planet
    final idx = _rnd.nextInt(0, 10000 ~/ density);
    return idx >= assets.planets.cols ? null : planets.getIndex(idx);
  }

  void _addPlanet(int col, int row) {
    final sprite = _randomPlanetSprite();
    if (sprite == null) return;
    final dx = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final dy = _rnd.nextDouble(_tileRangeMin, _tileRangeMax);
    final tp = TilePosition(col, row, dx, dy);
    final radiusFactor = _rnd.nextDouble(minRadius, maxRadius);
    final planet = Planet(tp, sprite, radiusFactor * planets.spriteWidth);
    _planets.add(planet);
  }

  void _initPlanets(Size size) {
    if (!needsRegenerate) return;
    final ncols = size.width / _tileSize * _oversizeFactor;
    final nrows = size.height / _tileSize * _oversizeFactor;
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
    final rect = Rect.fromCircle(center: worldOffset, radius: planet.radius);
    planet.sprite.renderRect(canvas, rect);
  }

  void render(Canvas canvas, Size size) {
    _initPlanets(size);
    canvas.translate(size.width / 2, size.height / 2);
    for (final planet in _planets) _renderPlanet(canvas, planet);
  }
}
