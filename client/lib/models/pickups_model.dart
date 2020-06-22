import 'package:batufo/arena/pickup.dart';

class PickupsModel {
  final List<Pickup> pickups;

  PickupsModel(this.pickups);

  Pickup findByColRow(int col, int row) {
    return pickups.firstWhere(
      (x) => x.tilePosition.col == col && x.tilePosition.row == row,
      orElse: () => null,
    );
  }

  void removePickup(String id) {
    pickups.removeWhere((x) => x.id == id);
  }
}
