import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/formatters/format_percentage.dart';

void main() {
  double valor = 12;

  test('Test Percentage formatter', () {
    expect(formatPercentage(valor), "12%");
    expect(formatPercentage(valor, showPercentage: false), "12");

    valor = 12.2;
    expect(formatPercentage(valor), "12%");
    expect(formatPercentage(valor, showPercentage: false), "12");

    valor = 12.5;
    expect(formatPercentage(valor), "13%");
    expect(formatPercentage(valor, showPercentage: false), "13");
  });
}
