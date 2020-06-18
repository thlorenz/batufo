import 'dart:ui'
    show
        Canvas,
        Image,
        Paint,
        PaintingStyle,
        Picture,
        PictureRecorder,
        Rect,
        Size;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;

final _imagePaint = Paint();

final Paint _debugVisibleRectPaint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.stroke
  ..strokeWidth = 4.0;

abstract class Scene {
  final bool enableRecording;
  final bool debugVisibleRect;

  Scene({
    @required this.enableRecording,
    this.debugVisibleRect = false,
  }) : recording = false;

  Picture _recordedPicture;
  Image _recordedImage;
  bool recording;

  @protected
  void resizeScene(Size fullSize) {}
  @protected
  void renderScene(Canvas canvas, Rect visibleRect);
  @protected
  bool get skipRender;

  void resize(Size size) {
    if (skipRender) return;
    resizeScene(size);

    if (enableRecording) {
      _recordedImage = null;
      _recordedPicture?.dispose();
      _recordedPicture = _recordPicture(size);
      _recordedPicture
          .toImage(size.width.ceil(), size.height.ceil())
          .then((x) => _recordedImage = x);
    }
  }

  void render(Canvas canvas, Rect visibleRect, Size size) {
    if (skipRender || visibleRect == null) return;
    if (enableRecording) {
      if (_recordedImage != null) {
        canvas.drawImageRect(
          _recordedImage,
          visibleRect,
          visibleRect,
          _imagePaint,
        );
      } else {
        canvas.drawPicture(_recordedPicture);
      }
    } else {
      renderScene(canvas, visibleRect);
    }
    if (debugVisibleRect && !recording) {
      canvas.drawRect(visibleRect, _debugVisibleRectPaint);
    }
  }

  Picture _recordPicture(Size size) {
    recording = true;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final visibleRect = Rect.fromLTWH(0, 0, size.width, size.height);
    renderScene(canvas, visibleRect);
    final picture = recorder.endRecording();
    recording = false;
    return picture;
  }
}
