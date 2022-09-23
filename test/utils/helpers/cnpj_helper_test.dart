import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/vvs_core.dart';

void main() {
  test('Test CNPJ validator', () {
    expect(CnpjHelper.isValid('12.175.094/0001-19'), true);
    expect(CnpjHelper.isValid('12.175.094/0001-18'), false);
    expect(CnpjHelper.isValid('17942159000128'), true);
    expect(CnpjHelper.isValid('17942159000128@mail.com', stripBeforeValidation: false), false);
    expect(CnpjHelper.isValid('17942159000128', stripBeforeValidation: false), true);
    expect(CnpjHelper.isValid('17942159000127'), false);
    expect(CnpjHelper.isValid('017942159000128'), false);

    var blackListed = <String>[
      '00000000000000',
      '11111111111111',
      '22222222222222',
      '33333333333333',
      '44444444444444',
      '55555555555555',
      '66666666666666',
      '77777777777777',
      '88888888888888',
      '99999999999999'
    ];

    for (var cnpj in blackListed) {
      expect(CnpjHelper.isValid(cnpj), false);
    }
  });

  test('Test CNPJ generator', () {
    for (var i = 0; i < 10; i++) {
      var raw = CnpjHelper.generate();
      var formatted = CnpjHelper.generate(useFormat: true);

      expect(raw != formatted, true);
      expect(CnpjHelper.isValid(raw), true);
      expect(CnpjHelper.isValid(formatted), true);
    }
  });

  test('Test CNPJ formatter', () {
    expect(CnpjHelper.format('00000000000000', anywhere: true), '00.000.000/0000-00');
    expect(CnpjHelper.format('85137090000110'), '85.137.090/0001-10');
  });

  test('Test CNPJ strip', () {
    expect(CnpjHelper.strip('85.137.090/0001-10'), '85137090000110');
  });
}
