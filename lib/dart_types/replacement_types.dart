const Required required = const Required();
const Immutable immutable = const Immutable();

class Required {
  final String reason;
  const Required([this.reason = '']);
}

class Immutable {
  final String reason;
  const Immutable([this.reason = '']);
}
