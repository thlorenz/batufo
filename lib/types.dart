import 'package:flutter/foundation.dart';

@immutable
class Tuple<T, U> {
  final T first;
  final U second;
  Tuple(this.first, this.second);
}
