// static String obterCpf(String cpf) {
//     assert(isCPFValido(cpf), 'CPF inválido!');
//     return CPFValidator.format(cpf);
//   }

//   /// Retorna o CNPJ informado, utilizando a máscara: `XX.YYY.ZZZ/NNNN-SS`
//   static String obterCnpj(String cnpj) {
//     assert(isCNPJValido(cnpj), 'CNPJ inválido!');
//     return CNPJValidator.format(cnpj);
//   }

import 'cnpj_helper.dart';
import 'cpf_helper.dart';

class CpfCnpjHelper {
  static const _stipRegex = r'[^\d]';

  static String format(String cpfCnpj, {bool anywhere = false}) {
    if (anywhere == false && !isValid(cpfCnpj)) {
      throw AssertionError('CPF ou CNPJ inválido!');
    }

    if (CnpjHelper.isValid(cpfCnpj, allowBlacklisted: true)) {
      return CnpjHelper.format(cpfCnpj, anywhere: anywhere);
    } else if (CpfHelper.isValid(cpfCnpj, allowBlacklisted: true)) {
      return CpfHelper.format(cpfCnpj, anywhere: anywhere);
    }

    return '';
  }

  static String strip(String? cpfCnpj) {
    var regex = RegExp(_stipRegex);
    cpfCnpj = cpfCnpj ?? '';

    return cpfCnpj.replaceAll(regex, '');
  }

  static bool isValid(String? cpfCnpj, {bool stripBeforeValidation = true}) {
    bool isValid = false;

    isValid = CpfHelper.isValid(cpfCnpj, stripBeforeValidation: stripBeforeValidation);
    if (isValid) return isValid;

    isValid = CnpjHelper.isValid(cpfCnpj, stripBeforeValidation: stripBeforeValidation);
    if (isValid) return isValid;

    return isValid;
  }
}
