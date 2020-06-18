import 'dart:ui';

import 'package:flutter/foundation.dart';

final _imagePaint = Paint();

abstract class Scene {
  final bool enableRecording;
  final double sizeFactor;

  Scene({@required this.enableRecording, this.sizeFactor = 1.0})
      : recording = false;

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
    final fullWidth = size.width * sizeFactor;
    final fullHeight = size.height * sizeFactor;
    final fullSize = Size(fullWidth, fullHeight);
    resizeScene(fullSize);

    if (enableRecording) {
      _recordedImage = null;
      _recordedPicture?.dispose();
      _recordedPicture = _recordPicture(fullSize);
      _recordedPicture
          .toImage(fullWidth.ceil(), fullHeight.ceil())
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
