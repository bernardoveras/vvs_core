class CepHelper {
  static bool isValid(String? cep) {
    if (cep == null || cep.isEmpty) return false;

    String cepSemPontuacao = cep.replaceAll('.', '').replaceAll('-', '');

    return cepSemPontuacao.length == 8;
  }

  static String format(String cep, {bool ponto = true, String onEmpty = "Não encontrado..."}) {
    if(cep.isEmpty) return onEmpty;
    if(cep.length < 8) return cep;
    return ponto
        ? '${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5, 8)}'
        : '${cep.substring(0, 2)}${cep.substring(2, 5)}-${cep.substring(5, 8)}';
  }

  static String strip(String cep) {
    return cep.replaceAll('.', '').replaceAll('-', '');
  }
}
