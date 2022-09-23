import 'package:intl/intl.dart';

/// Formata um número com o seguinte formato: `12%`
///
/// Exemplo de uso:
/// ```dart
/// String valorFormatado = formatPercentage(12);
/// print(valorFormatado); // "12%"
/// ```
String formatPercentage(num value, {bool showPercentage = true}) {
  final NumberFormat percentualFormat = NumberFormat('#,##0');

  var formatted = percentualFormat.format(value);

  if (showPercentage) {
    formatted = '$formatted%';
  }

  return formatted;
}
