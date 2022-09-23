import '../../extensions/string_extensions.dart';
import '../helpers/telefone_helper.dart';

/// Formata a string no seguinte pattern: (xx) xxxxx-xxxx
///
/// Exemplo de uso:
/// ```dart
/// String valorFormatado = formatTelefone(21999999999);
/// print(valorFormatado); // "(21) 99999-9999"
/// ```
String formatTelefone(String telefone, [bool ddd = true]) {
  if (telefone.isEmpty) return "";

  telefone = TelefoneHelper.strip(telefone).removeWhitespace();

  assert((telefone.length <= 15), 'Telefone com tamanho inválido. Deve conter 10 ou 11 caracteres');

  if (ddd) {
    assert((telefone.length == 10 || telefone.length == 11), 'Telefone com tamanho inválido. Deve conter 10 ou 11 caracteres');

    return telefone.length == 10
        ? '(${telefone.substring(0, 2)}) ${telefone.substring(2, 6)}-${telefone.substring(6, 10)}'
        : '(${telefone.substring(0, 2)}) ${telefone.substring(2, 7)}-${telefone.substring(7, 11)}';
  } else {
    assert((telefone.length == 8 || telefone.length == 9), 'Telefone com tamanho inválido. Deve conter 8 ou 9 caracteres');

    return (telefone.length == 8)
        ? '${telefone.substring(0, 4)}-${telefone.substring(4, 8)}'
        : '${telefone.substring(0, 5)}-${telefone.substring(5, 9)}';
  }
}
