const Required required = Required();
const Immutable immutable = Immutable();

class Required {
  final String reason;
  const Required([this.reason = '']);
}

class Immutable {
  final String reason;
  const Immutable([this.reason = '']);
}
