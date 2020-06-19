import 'package:batufo/arena/pickup.dart';

class PickupsModel {
  final List<Pickup> pickups;

  PickupsModel(this.pickups);

  void removePickup(String id) {
    pickups.removeWhere((x) => x.id == id);
  }

  PickupsModel clone() {
    final clonedPickups = pickups.map((x) => x.clone()).toList();
    return PickupsModel(clonedPickups);
  }
}
