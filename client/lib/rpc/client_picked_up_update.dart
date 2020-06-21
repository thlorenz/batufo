import 'package:batufo/arena/pickup.dart';
import 'package:batufo/rpc/generated/message_bus.pb.dart';
import 'package:batufo/rpc/packing_types.dart';

class ClientPickedUpUpdate {
  final Point colRow;

  const ClientPickedUpUpdate(this.colRow);

  factory ClientPickedUpUpdate.fromPickup(Pickup pickup) {
    return ClientPickedUpUpdate(
      Point(
        pickup.tilePosition.col,
        pickup.tilePosition.row,
      ),
    );
  }

  PackedClientPickedUpUpdate pack() {
    return PackedClientPickedUpUpdate()..colRow = colRow.pack();
  }

  factory ClientPickedUpUpdate.unpack(PackedClientPickedUpUpdate packed) {
    final colRow = Point.unpack(packed.colRow);
    return ClientPickedUpUpdate(colRow);
  }

  String toString() {
    return '''
    colRow $colRow
    ''';
  }
}
