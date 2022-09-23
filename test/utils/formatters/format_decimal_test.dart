import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/utils.dart';

void main() {
  const double valor = 1234567.89;

  test('Test Decimal formatter', () {
    expect(formatDecimal(valor), "1.234.567,89");
  });
}
