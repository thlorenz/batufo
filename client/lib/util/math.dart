import 'dart:math';

class RandomNumber {
  final Random _rnd = Random();

  int nextInt(int min, int max) {
    return (_rnd.nextDouble() * (max - min + 1)).floor() + min;
  }

  double nextDouble(double min, double max) {
    final delta = max - min;
    return (_rnd.nextDouble() * delta) + min;
  }

  bool nextBool() => _rnd.nextBool();
}
