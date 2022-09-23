import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/helpers/cep_helper.dart';

void main() {
  test('Test CEP validator', () {
    expect(CepHelper.isValid('23070-420'), true);
    expect(CepHelper.isValid('23070-2420'), false);
    expect(CepHelper.isValid('23.070-420'), true);
    expect(CepHelper.isValid('23.070-2420'), false);
    expect(CepHelper.isValid('23070420'), true);
    expect(CepHelper.isValid('223070420'), false);
  });

  test('Test CEP formatter', () {
    expect(CepHelper.format('23070420'), '23.070-420');
    expect(CepHelper.format('23070420', ponto: false), '23070-420');
    expect(CepHelper.format('23', ponto: false), '23');
    expect(CepHelper.format('', ponto: false, onEmpty: ''), isEmpty);
  });

  test('Test CEP strip', () {
    expect(CepHelper.strip('23070-420'), '23070420');
    expect(CepHelper.strip('23.070-420'), '23070420');
  });
}
