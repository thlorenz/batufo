class Assets {
  final player = 'assets/images/sprites/player.png';
}

class GameProps {
  static const tileSize = 40.0;

  static const keyboardPlayerRotationFactor = 0.004;
  static const keyboardPlayerThrustForce = 0.01; // Newton

  static const playerMass = 4000.0; // kg
  static const playerThrustAcceleration =
      keyboardPlayerThrustForce / playerMass; // m/s2

  static Assets get assets => Assets();
}
