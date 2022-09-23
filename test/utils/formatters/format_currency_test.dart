import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/utils.dart';

void main() {
  const double valor = 1234567.89;

  test('Test Currency formatter', () {
    final String valorFormatado = formatCurrency(valor);

    expect(valorFormatado.contains("1.234.567,89"), true);
    expect(valorFormatado.contains("R\$"), true);
  });
}
