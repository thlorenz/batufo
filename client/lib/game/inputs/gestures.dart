import 'package:batufo/game/inputs/input_types.dart';
import 'package:batufo/game_props.dart';
import 'package:flutter/material.dart';

class GameGestures {
  double _rotation;
  double _thrust;
  bool _fire;
  bool _switchedWeapon;
  GameGestures._()
      : _rotation = 0.0,
        _thrust = 0.0,
        _fire = false,
        _switchedWeapon = false;

  void onPanUpdate(DragUpdateDetails details) {
    final delta = details.delta;
    if (delta.dx.abs() > delta.dy.abs()) {
      _addRotation(delta.dx);
    } else if (delta.dy < -GameProps.gesturePlayerMinThrustDelta) {
      _addThrust(delta.dy);
    } else if (delta.dy > GameProps.gesturePlayerMinSwitchWeaponDelta) {
      _switchWeapon();
    }
  }

  void onTap() {
    _fire = true;
  }

  static final GameGestures _instance = GameGestures._();
  static GameGestures get instance => _instance;

  void _addRotation(double dx) {
    _rotation += -dx * GameProps.gesturePlayerRotationFactor;
  }

  void _addThrust(double dy) {
    _thrust += -dy;
  }

  void _switchWeapon() {
    _switchedWeapon = true;
  }

  AggregatedGestures get aggregatedGestures {
    final gestures = AggregatedGestures(
      rotation: _rotation,
      thrust: _thrust,
      fire: _fire,
      switchWeapon: _switchedWeapon,
    );
    _rotation = 0.0;
    _thrust = 0.0;
    _fire = false;
    _switchedWeapon = false;
    return gestures;
  }
}
