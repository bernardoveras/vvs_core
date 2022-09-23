enum TipoMensagem { alerta, sucesso, erro, erroCritico, info, erroPermissaoNegada }

extension TipoMensagemExtension on TipoMensagem {
  int get value => index;
}

extension IntExtension on int {
  TipoMensagem get tipoMensagem => TipoMensagem.values[this];
}