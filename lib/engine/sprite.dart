import 'dart:ui' show Canvas, Offset, Paint, Rect, Image;

import 'package:batufo/engine/images.dart';
import 'package:flutter/material.dart' show Colors;

final Paint _paint = Paint()..color = Colors.white;

class Sprite {
  Image image;
  bool _loaded;
  double width;
  double height;

  Sprite(
    String path, {
    double width,
    double height,
  }) : _loaded = false {
    Images.instance.load(path).then((img) {
      image = img;
      _sizeFromImage(width, height);
      _loaded = true;
    });
  }

  Sprite.fromImage(
    Image img, {
    double width,
    double height,
  }) {
    image = img;
    _sizeFromImage(width, height);
    _loaded = true;
  }

  static Future<Sprite> fromPath(
    String path, {
    double width,
    double height,
  }) async {
    final img = await Images.instance.load(path);
    return Sprite.fromImage(img, width: width, height: height);
  }

  void render(Canvas canvas, Offset center) {
    if (!_loaded) return;
    final x = center.dx;
    final y = center.dy;
    final src =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(x - width / 2, y - height / 2, width, height);
    canvas.drawImageRect(image, src, dst, _paint);
  }

  void _sizeFromImage(double w, double h) {
    width = w ?? image.width.toDouble();
    height = h ?? image.height.toDouble();
  }

  @override
  String toString() {
    return 'Sprite { width: $width, height: $height }';
  }
}
