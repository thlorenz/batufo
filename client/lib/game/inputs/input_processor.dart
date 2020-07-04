import 'dart:math';

import 'package:batufo/controllers/sound_controller.dart';
import 'package:batufo/game/inputs/input_types.dart';
import 'package:batufo/models/player_model.dart'
    show PlayerModel, Weapon, nextWeapon;
import 'package:flutter/foundation.dart';

const _pipi = 2 * pi;

class InputProcessor {
  final double keyboardThrustForce;
  final double keyboardRotationFactor;
  final double timeBetweenThrusts;
  final double timeBetweenBullets;
  final double timeBetweenBombs;
  final double timeBetweenActions;
  final SoundController soundController;

  double timeSinceLastThrust;
  double timeSinceLastBullet;
  double timeSinceLastBomb;
  double timeSinceSwitchWeapon;

  InputProcessor._({
    @required this.soundController,
    @required this.keyboardThrustForce,
    @required this.keyboardRotationFactor,
    @required this.timeBetweenThrusts,
    @required this.timeBetweenBullets,
    @required this.timeBetweenBombs,
    @required this.timeBetweenActions,
  }) {
    timeSinceLastThrust = 0.0;
    timeSinceLastBullet = 0.0;
    timeSinceLastBomb = 0.0;
    timeSinceSwitchWeapon = 0.0;
  }

  bool get canApplyThrust => timeBetweenThrusts <= timeSinceLastThrust;

  bool get canShootBullet => timeBetweenBullets <= timeSinceLastBullet;

  bool canSpawnBomb(PlayerModel hero) {
    return hero.hasBomb && timeBetweenBombs <= timeSinceLastBomb;
  }

  bool get canSwitchWeapon => timeBetweenActions <= timeSinceSwitchWeapon;

  int get percentReadyToShoot =>
      min((timeSinceLastBullet / timeBetweenBullets * 100).floor(), 100);

  int get percentReadyToThrust =>
      min((timeSinceLastThrust / timeBetweenThrusts * 100).floor(), 100);

  void udate(
    double dt,
    GameKeys keys,
    AggregatedGestures gestures,
    PlayerModel player,
  ) {
    // rotation
    if (keys.contains(GameKey.Left)) {
      player.angle = _increaseAngle(player.angle, dt * keyboardRotationFactor);
    }
    if (keys.contains(GameKey.Right)) {
      player.angle = _increaseAngle(player.angle, -dt * keyboardRotationFactor);
    }
    if (gestures.rotation != 0.0) {
      player.angle = _increaseAngle(player.angle, gestures.rotation);
    }
    timeSinceLastThrust = min(timeBetweenThrusts, timeSinceLastThrust + dt);
    timeSinceLastBullet = min(timeBetweenBullets, timeSinceLastBullet + dt);
    timeSinceLastBomb = min(timeBetweenBombs, timeSinceLastBomb + dt);
    timeSinceSwitchWeapon = min(timeBetweenActions, timeSinceSwitchWeapon + dt);

    // thrust
    if (canApplyThrust) {
      if (keys.contains(GameKey.Up) || gestures.thrust != 0.0) {
        soundController.playerAppliedThrust();
        player.appliedThrust = true;
        timeSinceLastThrust = 0.0;
      }
    }

    // plant bomb or shoot bullets
    if (keys.contains(GameKey.Fire) || gestures.fire) {
      if (player.currentWeapon == Weapon.Bullet && canShootBullet) {
        soundController.playerFiredBullet();
        player.shotBullet = true;
        player.nbullets--;
        timeSinceLastBullet = 0.0;
      } else if (player.currentWeapon == Weapon.Bomb && canSpawnBomb(player)) {
        player.spawnedBomb = true;
        player.nbombs--;
        timeSinceLastBomb = 0.0;
      }
    }

    // switch weapon
    if (canSwitchWeapon) {
      if (keys.contains(GameKey.Down) || gestures.switchWeapon) {
        soundController.playerSwitchedWeapon();
        player.currentWeapon = nextWeapon(player.currentWeapon);
        timeSinceSwitchWeapon = 0.0;
      }
    }
  }

  double _increaseAngle(double angle, double delta) {
    final res = angle + delta;
    // Make sure angle is never < 0 nor too large.
    // This is important for network communication as the double is packed
    // and sending negative value causes problems due to 31-bit limit in V8.
    if (res > _pipi) return res - _pipi;
    if (res < 0) return res + _pipi;
    return res;
  }

  static InputProcessor _instance;
  static InputProcessor get instance => _instance;

  static void create({
    @required SoundController soundController,
    @required double keyboardThrustForce,
    @required double keyboardRotationFactor,
    @required double timeBetweenThrusts,
    @required double timeBetweenBullets,
    @required double timeBetweenBombs,
    @required double timeBetweenActions,
  }) {
    assert(_instance == null, 'input processor should only be created once');
    _instance = InputProcessor._(
      soundController: soundController,
      keyboardThrustForce: keyboardThrustForce,
      keyboardRotationFactor: keyboardRotationFactor,
      timeBetweenThrusts: timeBetweenThrusts,
      timeBetweenBullets: timeBetweenBullets,
      timeBetweenBombs: timeBetweenBombs,
      timeBetweenActions: timeBetweenActions,
    );
  }
}
