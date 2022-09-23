import 'package:intl/intl.dart';

/// Formata um número com o seguinte formato: `1.000.000,00`
/// 
/// Exemplo de uso:
/// ```dart
/// String valorFormatado = formatDecimal(1234567.89);
/// print(valorFormatado); // "1.234.567,89"
/// ```
String formatDecimal(num number, {String locale = 'pt_BR'}) {
  return NumberFormat.decimalPattern(locale).format(number);
}
