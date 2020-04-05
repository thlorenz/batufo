import 'dart:math';

int getRandomInt() {
  final random = Random.secure();
  return random.nextInt(0xFFFFFFFF);
}
