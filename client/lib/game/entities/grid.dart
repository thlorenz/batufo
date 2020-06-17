import 'dart:ui' show Canvas, Offset, Paint, Rect;

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

  void render(Canvas canvas, Rect visibleRect, int nrows, int ncols) {
    final delta = _tileSize;
    final startX = visibleRect.left;
    final endX = visibleRect.right;
    final startY = visibleRect.top;
    final endY = visibleRect.bottom;

    for (double col = startX; col <= endX; col += delta) {
      canvas.drawLine(Offset(col, startY), Offset(col, endY), _gridPaint);
    }
    for (double row = startY; row <= endY; row += delta) {
      canvas.drawLine(Offset(startX, row), Offset(endX, row), _gridPaint);
    }
  }
}
