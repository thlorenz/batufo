import 'dart:math';

class RandomNumber {
  final Random _rnd = Random();

  int nextInt(int min, int max) {
    return _rnd.nextInt(max) + min;
  }

  double nextDouble(double min, double max) {
    final delta = max - min;
    return (_rnd.nextDouble() * delta) + min;
  }

  bool nextBool() => _rnd.nextBool();
}
