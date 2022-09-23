import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vvs_core/utils/utils.dart';

void main() {
  final DateTime data = DateTime(2022, 7, 13, 14, 30);

  setUp(() {
    initializeDateFormatting('pt_BR');
  });

  test('Test Date formatter', () {
    expect(formatDate(data), '13/07/2022');
    expect(formatDate(data, pattern: "EE', 'H':'mm"), 'qua, 14:30');
  });
}
