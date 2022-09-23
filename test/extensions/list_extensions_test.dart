import 'package:test/test.dart';
import 'package:vvs_core/extensions/list_extensions.dart';

void main() {
  test('sumBy', () {
    final list = [2, 2, 2, 4];
    final sum = list.sumBy((element) => element);
    expect(sum, equals(10));
  });

  test('separarComVirgulas', () {
    final list = ['a', 'b', 'c'];
    final splitted = list.separarComVirgulas();
    expect(splitted, equals('a, b, c'));
  });
}
