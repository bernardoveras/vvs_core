extension DoubleExtension on double {
  double arredondar(int casas) {
    return double.parse(toStringAsFixed(casas));
  }

  double casoForZero(double valor) {
    if (this == 0) {
      return valor;
    } else {
      return this;
    }
  }
}

extension Double2Extension on double? {
  double getValueOrDefault(double defaultValue) {
    return this ?? defaultValue;
  }
}
