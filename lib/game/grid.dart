import 'dart:ui' show Canvas, Offset, Paint, Size;

import 'package:flutter/material.dart' show Colors, PaintingStyle;

class Grid {
  final double _tileSize;

  final Paint _gridPaint;
  Grid(this._tileSize)
      : _gridPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.2;

  void render(Canvas canvas, Size size) {
    final delta = _tileSize;
    for (double col = 0.0; col < size.width; col += delta) {
      canvas.drawLine(Offset(col, 0), Offset(col, size.height), _gridPaint);
    }
    for (double row = 0.0; row < size.height; row += delta) {
      canvas.drawLine(Offset(0, row), Offset(size.width, row), _gridPaint);
    }
  }
}
