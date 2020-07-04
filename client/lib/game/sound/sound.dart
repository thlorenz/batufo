abstract class Sound {
  Future<void> playThrust(double volume);
  Future<void> playBullet(double volume);
  Future<void> playBulletExploded(double volume);
  Future<void> playBombExploding(double volume);
  Future<void> playPlayerHitWall(double volume);
  Future<void> playPickupMedkit(double volume);
  Future<void> playPickupShield(double volume);
  Future<void> playPickupBomb(double volume);
  Future<void> playSwitchWeapon();
  Future<void> playTeleport();

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

  Future<void> playBombExploding(double volume) {
    return Future.value();
  }

  Future<void> playPlayerHitWall(double volume) {
    return Future.value();
  }

  Future<void> playPickupMedkit(double volume) {
    return Future.value();
  }

  Future<void> playPickupShield(double volume) {
    return Future.value();
  }

  Future<void> playPickupBomb(double volume) {
    return Future.value();
  }

  Future<void> playSwitchWeapon() {
    return Future.value();
  }

  Future<void> playTeleport() {
    return Future.value();
  }

  void disableLog() {}
}
