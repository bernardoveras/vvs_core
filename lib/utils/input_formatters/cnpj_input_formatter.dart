import 'package:flutter/services.dart';

import 'compound_formatter.dart';

/// Formata o valor do campo com a mascara de CNPJ `99.999.999/9999-99`
class CnpjInputFormatter extends TextInputFormatter
    implements CompoundableFormatter {
  /// Define o tamanho máximo do campo.
  @override
  int get maxLength => 14;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    if (newValueLength > maxLength) {
      return oldValue;
    }

    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength >= 3) {
      newText.write(newValue.text.substring(0, substrIndex = 2) + '.');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newValueLength >= 6) {
      newText.write(newValue.text.substring(2, substrIndex = 5) + '.');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newValueLength >= 9) {
      newText.write(newValue.text.substring(5, substrIndex = 8) + '/');
      if (newValue.selection.end >= 8) selectionIndex++;
    }
    if (newValueLength >= 13) {
      newText.write(newValue.text.substring(8, substrIndex = 12) + '-');
      if (newValue.selection.end >= 12) selectionIndex++;
    }
    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}