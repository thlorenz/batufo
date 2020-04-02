import 'package:batufo/game_props.dart';
import 'package:batufo/inputs/input_types.dart';
import 'package:flutter/material.dart';

class GameGestures {
  double _rotation;
  double _thrust;
  GameGestures._()
      : _rotation = 0.0,
        _thrust = 0.0;

  void onPanUpdate(DragUpdateDetails details) {
    final delta = details.delta;
    if (delta.dx.abs() > delta.dy.abs()) {
      _addRotation(delta.dx);
    } else if (delta.dy < -GameProps.gesturePlayerMinThrustDelta) {
      _addThrust(delta.dy);
    }
  }

  static final GameGestures _instance = GameGestures._();
  static GameGestures get instance => _instance;

  void _addRotation(double dx) {
    _rotation += -dx * GameProps.gesturePlayerRotationFactor;
  }

  void _addThrust(double dy) {
    _thrust += -dy * GameProps.gesturePlayerThrustFactor;
  }

  AggregatedGestures get aggregatedGestures {
    final gestures = AggregatedGestures(
      rotation: _rotation,
      thrust: _thrust,
    );
    _rotation = 0.0;
    _thrust = 0.0;
    return gestures;
  }
}
