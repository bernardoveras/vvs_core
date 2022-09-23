import 'package:intl/intl.dart';

/// Formata o número com o seguinte pattern: `R$ 9.999,99`
/// 
/// Exemplo de uso:
/// ```dart
/// String valorFormatado = formatCurrency(1234567.89);
/// print(valorFormatado); // "R$ 1.234.567,89"
/// ```
String formatCurrency(num number, {String locale = 'pt_BR'}) {
  return NumberFormat.simpleCurrency(locale: locale).format(number);
}
