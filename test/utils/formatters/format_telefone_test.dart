import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/formatters/format_telefone.dart';

void main() {
  String telefone = '21999999999';

  test('Test Telefone Formatter', () {
    expect(formatTelefone(telefone), "(21) 99999-9999");
    telefone = '21 999999999';
    expect(formatTelefone(telefone), "(21) 99999-9999");
    telefone = '(21) 99999-9999';
    expect(formatTelefone(telefone), "(21) 99999-9999");
  });
}
