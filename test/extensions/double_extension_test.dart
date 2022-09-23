import 'package:test/test.dart';
import 'package:vvs_core/extensions/double_extension.dart';

void main() {
  double valor = 15.46;

  test('Arredondar valor', () {
    expect(valor.arredondar(2), 15.46);
    expect(valor.arredondar(1), 15.5);
    expect(valor.arredondar(0), 15);

    valor = 15.4647;
    expect(valor.arredondar(2), 15.46);
    valor = 15.4651;
    expect(valor.arredondar(2), 15.47);
  });

  test('Caso for zero', () {
    valor = 10;
    expect(valor.casoForZero(4), 10);
    valor  = 0;
    expect(valor.casoForZero(5), 5);
  });
}
