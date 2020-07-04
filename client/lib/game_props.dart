import 'dart:math' show pi;

import 'package:batufo/setup/config.dart';
import 'package:flutter/foundation.dart';

const PORT = 2222;

class ParallaxProps {
  final int starsBackDensity;
  final int starsMiddleDensity;
  final int starsFrontDensity;
  final int planetsBackDensity;
  final int planetsFrontDensity;

  ParallaxProps({
    @required this.starsBackDensity,
    @required this.starsMiddleDensity,
    @required this.starsFrontDensity,
    @required this.planetsBackDensity,
    @required this.planetsFrontDensity,
  });

  factory ParallaxProps.forDesktop() {
    return ParallaxProps(
        starsBackDensity: 22,
        starsMiddleDensity: 6,
        starsFrontDensity: 2,
        planetsBackDensity: 10,
        planetsFrontDensity: 2);
  }

  factory ParallaxProps.forMobile() {
    return ParallaxProps.forDesktop();
  }

  factory ParallaxProps.forWeb() {
    return ParallaxProps(
        starsBackDensity: 16,
        starsMiddleDensity: 4,
        starsFrontDensity: 2,
        planetsBackDensity: 6,
        planetsFrontDensity: 1);
  }

  factory ParallaxProps.forPlatForm(PlatformType platform) {
    switch (platform) {
      case PlatformType.MacOS:
      case PlatformType.Linux:
      case PlatformType.Windows:
      case PlatformType.Fuchsia:
        return ParallaxProps.forDesktop();
      case PlatformType.Android:
      case PlatformType.IOS:
        return ParallaxProps.forMobile();
      case PlatformType.Web:
        return ParallaxProps.forWeb();
      default:
        return ParallaxProps.forMobile();
    }
  }
}

class GameProps {
  static const gesturePlayerRotationFactor = 0.04;
  static const gesturePlayerMinThrustDelta = 2.2;
  static const gesturePlayerMinSwitchWeaponDelta = 2.2;

  static const keyboardPlayerRotationFactor = 0.004;
  static const playerThrustForce = 0.07; // Newton

  static const playerMass = 4000.0; // kg
  static const playerThrustAcceleration =
      playerThrustForce / playerMass; // m/s2
  static const playerHitsWallSlowdown = 0.3;
  static const playerSizeFactor = 0.75;
  static const playerTotalHealth = 100.0;
  static const playerInitialBombs = 3;
  static const playerInitialBullets = 100;

  static const playerHitsWallHealthFactor = 30.0;
  static const bulletHitsPlayerHealthToll = playerTotalHealth / 20;
  static const medkitPlayerHealthGain = playerTotalHealth * 0.35;

  static const playerThrustAnimationDurationMs = 200.0;

  static const bulletForce = 0.4;
  static const bulletMsToExplode = 200.0;

  static const shieldDurationMs = 35000.0;
  static const shieldRadiusFactor = 1.4;
  static const shieldBulletHitLostMs = 5000;

  static const bombStartExplosionStrength = 10.0;
  static const bombTimeToExplodeMs = 5000.0;
  static const bombTimeExplodingMs = 1000.0;
  static const bombExplosionRadiusSquared = 100000.0;
  static const bombDealtDamageFromStrengthFactor = playerTotalHealth /
      (bombStartExplosionStrength * bombExplosionRadiusSquared) *
      7500.0;
  static const bombReducedShieldFromStrengthFactor = shieldDurationMs /
      (bombStartExplosionStrength * bombExplosionRadiusSquared) *
      8000.0;

  static bool get debugPlayerHitTile => false;
  static bool get debugWallHitTile => false;
  static bool get debugGrid => false;
  static bool get debugZ0VisibleRect => false;
  static bool get debugZ10VisibleRect => false;
  static bool get debugZ20VisibleRect => false;
  static bool get debugZ30VisibleRect => false;
  static bool get debugZ40VisibleRect => false;
  static bool get debugZ100VisibleRect => false;

  static bool get renderFloor => true;

  static const playerInputSyncIntervalMs = 50.0;
  static const timeBetweenThrustsMs = 500.0;
  static const timeBetweenBulletsMs = 250.0;
  static const timeBetweenBombsMs = 1000.0;
  static const timeBetweenActionssMs = 200.0;

  static const scoreOnHit = 100;
  static const scoreOnKill = 500;
  static const bombScoreFromStrengthFactor =
      bombDealtDamageFromStrengthFactor * 10.0;

  static const z10Lerp = 0.15;
  static const z20Lerp = 0.15;
  static const z30Lerp = 0.15;
  static const z40Lerp = 0.15;
  static const z100Lerp = 1.0;

  static const maxFiredBulletVolume = 0.8;
  static const maxBulletExplodedVolume = 1.0;
  static const maxBombExplodingVolume = 10.0;
  static const maxPlayerHitWallVolume = 0.8;
  static const appliedThrustVolume = 0.4;
  static const maxPickupShieldVolume = 0.5;
  static const maxPickupMedkitVolume = 0.5;
  static const maxPickupBombVolume = 0.4;
  static const switchWeaponVolume = 0.9;
  static const teleportVolume = 0.9;

  static const radarDeltaAngle = pi / 5;
  static const radarMaxLength = 1500.0;

  static const teleportRadiusFromTileSizeFactor = 1.5;
  static const teleportTileHitRadius = 1;
  static const teleportTotalTimeInMs = 2000.0;

  static const localhost = 'http://localhost:$PORT';
  static const localbox = 'http://192.168.1.7:$PORT';
  static const cloudbox = 'http://socket.batufo.space';
}
