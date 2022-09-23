import 'package:flutter/services.dart';

/// Define um [TextInputFormatter] que pode ser combinado com outros
/// para que seja possível interpolar de um para outro
/// Usado em [CompoundableFormatter]
abstract class CompoundableFormatter extends TextInputFormatter {
  /// Tamanho máximo do Formatter
  int get maxLength;
}

/// Combina dois ous mais instâncias de [Formatter] de forma que
/// seja possível interpolar de um para outro
class CompoundFormatter extends TextInputFormatter {
  /// Guarda uma lista de [CompoundableFormatter] que são encadeados
  /// na mesma ordem em que estão posicionados na lista
  final List<CompoundableFormatter> _formatters;

  CompoundFormatter(this._formatters)
      : assert(_formatters.isNotEmpty),
        assert(_formatters.length > 1);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final delegatedFormatter = _formatters.firstWhere((formatter) {
      final newValueLength = newValue.text.length;
      final maxLength = formatter.maxLength;
      return newValueLength <= maxLength;
    }, orElse: () {
      return _formatters.first;
    });
    return delegatedFormatter.formatEditUpdate(oldValue, newValue);
  }
}