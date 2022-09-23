import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/vvs_core.dart';

void main() {
  test('Test CPF/CNPJ validator', () {
    expect(CpfCnpjHelper.isValid('12.175.094/0001-19'), true);
    expect(CpfCnpjHelper.isValid('12.175.094/0001-18'), false);
    expect(CpfCnpjHelper.isValid('17942159000128'), true);
    expect(CpfCnpjHelper.isValid('17942159000128@mail.com', stripBeforeValidation: false), false);
    expect(CpfCnpjHelper.isValid('17942159000128', stripBeforeValidation: false), true);
    expect(CpfCnpjHelper.isValid('17942159000127'), false);
    expect(CpfCnpjHelper.isValid('017942159000128'), false);

    expect(CpfCnpjHelper.isValid('334.616.710-02'), true);
    expect(CpfCnpjHelper.isValid('334.616.710-01'), false);
    expect(CpfCnpjHelper.isValid('35999906032'), true);
    expect(CpfCnpjHelper.isValid('35999906031'), false);
    expect(CpfCnpjHelper.isValid('033461671002'), false);
    expect(CpfCnpjHelper.isValid('03346teste1671002@mail', stripBeforeValidation: false), false);
    expect(CpfCnpjHelper.isValid('57abc803.6586-52', stripBeforeValidation: false), false);
    expect(CpfCnpjHelper.isValid('03.3461.67100-2'), false);

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
      '99999999999999',
      '00000000000',
      '11111111111',
      '22222222222',
      '33333333333',
      '44444444444',
      '55555555555',
      '66666666666',
      '77777777777',
      '88888888888',
      '99999999999',
      '12345678909'
    ];

    for (var cnpj in blackListed) {
      expect(CpfCnpjHelper.isValid(cnpj), false);
    }
  });

  test('Test CPF/CNPJ formatter', () {
    expect(CpfCnpjHelper.format('00000000000000', anywhere: true), '00.000.000/0000-00');
    expect(CpfCnpjHelper.format('85137090000110'), '85.137.090/0001-10');

    expect(CpfCnpjHelper.format('33461671002'), '334.616.710-02');
    expect(CpfCnpjHelper.format('00000000000', anywhere: true), '000.000.000-00');
  });

  test('Test CPF/CNPJ strip', () {
    expect(CpfCnpjHelper.strip('85.137.090/0001-10'), '85137090000110');
    expect(CpfCnpjHelper.strip('334.616.710-02'), '33461671002');
  });
}
