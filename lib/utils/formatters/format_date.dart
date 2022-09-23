import 'package:intl/intl.dart';

/// Formata uma data para o formato dd/mm/yyyy
///
/// Exemplo de uso:
/// ```dart
/// String dataFormatada = formatDate(DateTime.now());
/// print(dataFormatada); // "01/01/2022"
/// ```
String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy', String locale = 'pt_BR'}) {
  return DateFormat(pattern, locale).format(date);
}
