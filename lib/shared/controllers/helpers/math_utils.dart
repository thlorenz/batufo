double roundPrecisionTwo(double n) {
  const mod = 100;
  final double nn = n * mod;
  return nn.round() / mod;
}
