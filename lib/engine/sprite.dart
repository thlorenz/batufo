import 'dart:ui' show Canvas, Offset, Paint, Rect, Image;

import 'package:batufo/engine/images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

final Paint _paint = Paint()..color = Colors.white;

class Sprite {
  Image image;
  bool _loaded;
  Rect src;

  Sprite(
    String path, {
    double x = 0.0,
    double y = 0.0,
    double width,
    double height,
  }) : _loaded = false {
    Images.instance.load(path).then((img) {
      _init(img, x, y, width, height);
    });
  }

  Sprite.fromImage(
    Image img, {
    double x = 0.0,
    double y = 0.0,
    double width,
    double height,
  }) {
    _init(img, x, y, width, height);
  }

  static Future<Sprite> fromPath(
    String path, {
    double width,
    double height,
  }) async {
    final img = await Images.instance.load(path);
    return Sprite.fromImage(img, width: width, height: height);
  }

  void renderRect(Canvas canvas, Rect rect) {
    render(
      canvas,
      rect.center,
      width: rect.size.width,
      height: rect.size.height,
    );
  }

  void render(Canvas canvas, Offset center,
      {@required double width, @required double height}) {
    if (!_loaded) return;
    final x = center.dx;
    final y = center.dy;
    final dst = Rect.fromLTWH(x - width / 2, y - height / 2, width, height);
    canvas.drawImageRect(image, src, dst, _paint);
  }

  void _init(Image img, double x, double y, double width, double height) {
    image = img;
    width ??= img.width.toDouble();
    height ??= img.height.toDouble();
    src = Rect.fromLTWH(x, y, width, height);
    _loaded = true;
  }
}
