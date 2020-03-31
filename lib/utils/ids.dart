import 'dart:math';

int getRandomInt() {
  var random = Random.secure();
  return random.nextInt(0xFFFFFFFF);
}
