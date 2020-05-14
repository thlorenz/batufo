import 'dart:ui' show Canvas, Paint, Offset;

import 'package:flutter/material.dart' show Colors, PaintingStyle;

class Grid {
  final double _tileSize;
  final double marginCols;
  final double marginRows;

  final Paint _gridPaint;
  Grid(this._tileSize, {this.marginRows = 5.0, this.marginCols = 5.0})
      : _gridPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.2;

  void render(Canvas canvas, int nrows, int ncols) {
    final delta = _tileSize;
    final gameWidth = ncols * delta;
    final gameHeight = nrows * delta;
    final marginX = marginCols * delta;
    final marginY = marginRows * delta;
    final startX = -marginX;
    final endX = gameWidth + marginX;
    final startY = -marginY;
    final endY = gameHeight + marginY;

    for (double col = startX; col <= endX; col += delta) {
      canvas.drawLine(Offset(col, startY), Offset(col, endY), _gridPaint);
    }
    for (double row = startY; row <= endY; row += delta) {
      canvas.drawLine(Offset(startX, row), Offset(endX, row), _gridPaint);
    }
  }
}
