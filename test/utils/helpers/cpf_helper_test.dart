import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/vvs_core.dart';

void main() {
  test('Test CPF validator', () {
    expect(CpfHelper.isValid('334.616.710-02'), true);
    expect(CpfHelper.isValid('334.616.710-01'), false);
    expect(CpfHelper.isValid('35999906032'), true);
    expect(CpfHelper.isValid('35999906031'), false);
    expect(CpfHelper.isValid('033461671002'), false);
    expect(CpfHelper.isValid('03346teste1671002@mail', stripBeforeValidation: false), false);
    expect(CpfHelper.isValid('57abc803.6586-52', stripBeforeValidation: false), false);
    expect(CpfHelper.isValid('03.3461.67100-2'), false);

    var blockList = <String>[
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

    for (var cpf in blockList) {
      expect(CpfHelper.isValid(cpf), false);
    }
  });

  test('Test CPF generator', () {
    for (var i = 0; i < 10; i++) {
      var raw = CpfHelper.generate();
      var formatted = CpfHelper.generate(useFormat: true);

      expect(raw != formatted, true);
      expect(CpfHelper.isValid(raw), true);
      expect(CpfHelper.isValid(formatted), true);
    }
  });

  test('Test CPF formatter', () {
    expect(CpfHelper.format('33461671002'), '334.616.710-02');
    expect(CpfHelper.format('00000000000', anywhere: true), '000.000.000-00');
  });

  test('Test CPF strip', () {
    expect(CpfHelper.strip('334.616.710-02'), '33461671002');
  });
}
