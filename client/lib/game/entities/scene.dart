import 'dart:ui';

import 'package:flutter/foundation.dart';

final _imagePaint = Paint();

abstract class Scene {
  final bool enableRecording;
  final double sizeFactor;

  Scene({@required this.enableRecording, this.sizeFactor = 1.0});

  Picture _recordedPicture;
  Image _recordedImage;

  @protected
  void resizeScene(Size fullSize) {}
  @protected
  void renderScene(Canvas canvas, Rect visibleRect, Size size);
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
        canvas.drawImage(_recordedImage, Offset.zero, _imagePaint);
      } else {
        canvas.drawPicture(_recordedPicture);
      }
    } else {
      renderScene(canvas, visibleRect, size);
    }
  }

  Picture _recordPicture(Size size) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    // TODO: most likely should record all and render only parts
    // renderScene(canvas, size);
    return recorder.endRecording();
  }
}
