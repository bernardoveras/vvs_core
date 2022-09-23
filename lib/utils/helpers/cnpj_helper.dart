// static String obterCpf(String cpf) {
//     assert(isCPFValido(cpf), 'CPF inválido!');
//     return CPFValidator.format(cpf);
//   }

//   /// Retorna o CNPJ informado, utilizando a máscara: `XX.YYY.ZZZ/NNNN-SS`
//   static String obterCnpj(String cnpj) {
//     assert(isCNPJValido(cnpj), 'CNPJ inválido!');
//     return CNPJValidator.format(cnpj);
//   }

import 'dart:math';

class CnpjHelper {
  static const List<String> blockList = [
    '00000000000000',
    '11111111111111',
    '22222222222222',
    '33333333333333',
    '44444444444444',
    '55555555555555',
    '66666666666666',
    '77777777777777',
    '88888888888888',
    '99999999999999'
  ];

  static const stipRegex = r'[^\d]';

  // Compute the Verifier Digit (or 'Dígito Verificador (DV)' in PT-BR).
  // You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
  static int _verifierDigit(String cnpj) {
    var index = 2;

    var reverse = cnpj.split('').map((s) => int.parse(s)).toList().reversed.toList();

    var sum = 0;

    for (var number in reverse) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    }

    var mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }

  static String format(String cnpj, {bool anywhere = false}) {
    if (anywhere == false && !isValid(cnpj)) {
      throw AssertionError('CNPJ inválido!');
    }

    var regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');

    return strip(cnpj).replaceAllMapped(regExp, (Match m) => '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}');
  }

  static String strip(String? cnpj) {
    var regex = RegExp(stipRegex);
    cnpj = cnpj ?? '';

    return cnpj.replaceAll(regex, '');
  }

  static bool isValid(String? cnpj, {bool stripBeforeValidation = true, bool allowBlacklisted = false}) {
    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }

    // cnpj must be defined
    if (cnpj == null || cnpj.isEmpty) {
      return false;
    }

    // cnpj must have 14 chars
    if (cnpj.length != 14) {
      return false;
    }

    // cnpj can't be blacklisted
    if (allowBlacklisted == false && blockList.contains(cnpj)) {
      return false;
    }

    var numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) == cnpj.substring(cnpj.length - 2);
  }

  static String generate({bool useFormat = false}) {
    var numbers = '';

    for (var i = 0; i < 12; i += 1) {
      numbers += Random().nextInt(9).toString();
    }

    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return (useFormat ? format(numbers) : numbers);
  }
}
