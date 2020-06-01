import 'package:batufo/game_props.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class StatsState extends Equatable {
  final double health;
  final int playersAlive;
  final int totalPlayers;
  final int percentReadyToShoot;
  final int percentReadyToThrust;
  final int score;

  const StatsState({
    @required this.health,
    @required this.totalPlayers,
    @required this.playersAlive,
    @required this.percentReadyToShoot,
    @required this.percentReadyToThrust,
    @required this.score,
  });

  StatsState copyWith({
    double health,
    int playersAlive,
    int totalPlayers,
    int percentReadyToShoot,
    int percentReadyToThrust,
    int score,
  }) {
    return StatsState(
      health: health ?? this.health,
      playersAlive: playersAlive ?? this.playersAlive,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      percentReadyToShoot: percentReadyToShoot ?? this.percentReadyToShoot,
      percentReadyToThrust: percentReadyToThrust ?? this.percentReadyToThrust,
      score: score ?? this.score,
    );
  }

  String toString() {
    return 'Stats [ $health, $playersAlive/$totalPlayers, $score ]';
  }

  static StatsState initial(int totalPlayers) {
    return StatsState(
      health: GameProps.playerTotalHealth,
      playersAlive: totalPlayers,
      totalPlayers: totalPlayers,
      percentReadyToShoot: 100,
      percentReadyToThrust: 100,
      score: 0,
    );
  }

  static StatsState get empty => StatsState(
        health: 0,
        playersAlive: 0,
        totalPlayers: 0,
        percentReadyToShoot: 0,
        percentReadyToThrust: 0,
        score: 0,
      );

  @override
  List<Object> get props => [
        health,
        totalPlayers,
        playersAlive,
        percentReadyToShoot,
        percentReadyToThrust,
        score,
      ];
}
