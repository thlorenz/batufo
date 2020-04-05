import 'dart:async';

class StatsModel {
  double _playerHealth;

  final StreamController<StatsModel> _update$;

  StatsModel({double playerHealth})
      : _playerHealth = playerHealth,
        _update$ = StreamController();

  double get playerHealth => _playerHealth;

  set playerHealth(double value) {
    _playerHealth = value;
    _update$.add(this);
  }

  Stream<StatsModel> get update$ => _update$.stream;
}
