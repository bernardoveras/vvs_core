import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/utils/resulter.dart';

void main() {
  test('Deve retornar isSuccess true e o result 100', () {
    var result = Resulter<int, String>.success(100);

    expect(result.isSuccess, true);
    expect(result.isError, false);

    expect(result.result, 100);
    expect(result.error, null);
  });
  test('Deve retornar isSuccess true e o result null', () {
    var result = Resulter<int, String>.success();

    expect(result.isSuccess, true);
    expect(result.isError, false);

    expect(result.result, null);
    expect(result.error, null);
  });
  test('Deve retornar isError true e o result null', () {
    var result = Resulter<int, String>.error('Ocorreu um erro');

    expect(result.isSuccess, false);
    expect(result.isError, true);

    expect(result.result, null);
    expect(result.error, 'Ocorreu um erro');
  });
  test('Deve retornar isError true e o result 100', () {
    var result = Resulter<int, String>.error('Ocorreu um erro', 100);

    expect(result.isSuccess, false);
    expect(result.isError, true);

    expect(result.result, 100);
    expect(result.error, 'Ocorreu um erro');
  });
}
