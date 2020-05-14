import 'package:batufo/engine/sprite.dart';
import 'package:batufo/engine/sprite_sheet.dart';

class SpriteSheetAnimation {
  final SpriteSheet _spriteSheet;
  final double durationMs;
  final bool loop;
  final double _frameMs;
  final int _framesCount;

  int _currentIdx;
  double _clock;

  SpriteSheetAnimation(
    this._spriteSheet,
    this.durationMs, {
    this.loop = false,
  })  : _clock = 0.0,
        _framesCount = _spriteSheet.spritesCount,
        _frameMs = durationMs / _spriteSheet.spritesCount {
    reset();
  }

  Sprite get sprite => _spriteSheet.getIndex(_currentIdx);
  bool get done => _currentIdx >= _framesCount;

  void update(double dt) {
    if (done) return;
    _clock += dt;
    _currentIdx = (_clock / _frameMs).round();
    if (loop && _currentIdx >= _framesCount) reset();
  }

  void reset() {
    _currentIdx = 0;
    _clock = 0;
  }
}
