abstract class Sound {
  Future<void> playThrust(double volume);
  Future<void> playBullet(double volume);
  Future<void> playBulletExploded(double volume);
  Future<void> playPlayerHitWall(double volume);
  Future<void> playPickupShield(double volume);

  void disableLog();
}

class DisabledSound extends Sound {
  Future<void> playThrust(double volume) {
    return Future.value();
  }

  Future<void> playBullet(double volume) {
    return Future.value();
  }

  Future<void> playBulletExploded(double volume) {
    return Future.value();
  }

  Future<void> playPlayerHitWall(double volume) {
    return Future.value();
  }

  Future<void> playPickupShield(double volume) {
    return Future.value();
  }

  void disableLog() {}
}
