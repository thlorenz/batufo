import 'dart:ui' show Canvas;
import 'dart:ui';

import 'package:batufo/arena/teleport.dart';
import 'package:batufo/types.dart';
import 'package:flutter/material.dart';

final _paintsByIndex = [
  Color(0xFF222299),
  Colors.green,
  Colors.yellow,
  Colors.red,
  Colors.white,
  Colors.deepPurple,
  Colors.deepOrange,
  Colors.black,
  Colors.grey,
]
    .map((x) => Tuple(
        Paint()
          ..color = x.withOpacity(0.44)
          ..style = PaintingStyle.fill,
        Paint()
          ..color = x
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0))
    .toList();

class _TeleportEntity {
  final Rect rect;
  final Tuple<Paint, Paint> paints;
  _TeleportEntity(this.rect, this.paints);

  void render(Canvas canvas) {
    canvas.drawCircle(rect.center, rect.width, paints.first);
    canvas.drawCircle(rect.center, rect.width, paints.second);
  }
}

class Teleports {
  final List<Teleport> teleports;
  final int _tileSize;
  final double _radiusFromTileSizeFactor;
  final List<_TeleportEntity> _teleportEntities;

  bool skipRender = false;

  Teleports(this.teleports, this._tileSize, this._radiusFromTileSizeFactor)
      : _teleportEntities = <_TeleportEntity>[] {
    _initRects();
  }

  void resize(Size size) {}

  void render(Canvas canvas, Rect visibleRect) {
    _initRects();
    for (final entity in _teleportEntities) {
      if (visibleRect != null && !entity.rect.overlaps(visibleRect)) continue;
      entity.render(canvas);
    }
  }

  void _initRects() {
    _teleportEntities.clear();
    assert(teleports.length <= _paintsByIndex.length,
        'max of ${_paintsByIndex.length} teleports allowed per level');

    int idx = 0;
    for (final teleport in teleports) {
      final wpa = teleport.portA.toWorldPosition();
      final wpb = teleport.portB.toWorldPosition();
      final r = _tileSize * _radiusFromTileSizeFactor;
      final recta = Rect.fromLTWH(wpa.x - r / 2, wpa.y - r / 2, r, r);
      final rectb = Rect.fromLTWH(wpb.x - r / 2, wpb.y - r / 2, r, r);
      _teleportEntities
        ..add(_TeleportEntity(
          recta,
          _paintsByIndex[idx],
        ))
        ..add(_TeleportEntity(
          rectb,
          _paintsByIndex[idx],
        ));
      idx++;
    }
  }
}
