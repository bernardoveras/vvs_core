import 'package:test/test.dart';
import 'package:vvs_core/extensions/string_extensions.dart';

void main() {
  test('removeWhitespace', () async {
    String string = ' test ';
    expect(string.removeWhitespace(), 'test');

    string = ' test and test     ';
    expect(string.removeWhitespace(), 'testandtest');
  });
}