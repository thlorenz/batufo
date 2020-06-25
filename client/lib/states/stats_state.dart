import 'package:batufo/game_props.dart';
import 'package:batufo/models/player_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class StatsState extends Equatable {
  final double health;
  final int playersAlive;
  final int totalPlayers;
  final int percentReadyToShoot;
  final int percentReadyToThrust;
  final int score;
  final int nbombs;
  final int nbullets;
  final Weapon weapon;

  const StatsState({
    @required this.health,
    @required this.totalPlayers,
    @required this.playersAlive,
    @required this.percentReadyToShoot,
    @required this.percentReadyToThrust,
    @required this.score,
    @required this.nbombs,
    @required this.nbullets,
    @required this.weapon,
  });

  StatsState copyWith({
    double health,
    int playersAlive,
    int totalPlayers,
    int percentReadyToShoot,
    int percentReadyToThrust,
    int score,
    int nbombs,
    int nbullets,
    Weapon weapon,
  }) {
    return StatsState(
      health: health ?? this.health,
      playersAlive: playersAlive ?? this.playersAlive,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      percentReadyToShoot: percentReadyToShoot ?? this.percentReadyToShoot,
      percentReadyToThrust: percentReadyToThrust ?? this.percentReadyToThrust,
      score: score ?? this.score,
      nbombs: nbombs ?? this.nbombs,
      nbullets: nbullets ?? this.nbullets,
      weapon: weapon ?? this.weapon,
    );
  }

  String toString() {
    return '''Stats [
     $health, $playersAlive/$totalPlayers, $score,
     $percentReadyToShoot, $percentReadyToThrust,
     $nbombs, $nbullets, $weapon
    ]''';
  }

  static StatsState initial(int totalPlayers) {
    return StatsState(
      health: GameProps.playerTotalHealth,
      playersAlive: 1,
      totalPlayers: totalPlayers,
      percentReadyToShoot: 100,
      percentReadyToThrust: 100,
      score: 0,
      nbombs: 0,
      nbullets: 0,
      weapon: Weapon.Bullet,
    );
  }

  static StatsState get empty => StatsState(
        health: 0,
        playersAlive: 0,
        totalPlayers: 0,
        percentReadyToShoot: 0,
        percentReadyToThrust: 0,
        score: 0,
        nbombs: 0,
        nbullets: 0,
        weapon: Weapon.Bullet,
      );

  @override
  List<Object> get props => [
        health,
        totalPlayers,
        playersAlive,
        percentReadyToShoot,
        percentReadyToThrust,
        score,
        nbombs,
        nbullets,
        weapon,
      ];
}
