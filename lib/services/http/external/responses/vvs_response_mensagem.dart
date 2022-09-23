import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'tipo_mensagem.dart';

class VvsResponseMensagem extends Equatable {
  const VvsResponseMensagem({
    required this.texto,
    required this.tipo,
  });

  final String texto;
  final TipoMensagem tipo;

  factory VvsResponseMensagem.fromMap(Map<String, dynamic> map) {
    return VvsResponseMensagem(
      texto: map['Texto'] as String,
      tipo: (map['Tipo'] as int).tipoMensagem,
    );
  }

  factory VvsResponseMensagem.fromJson(String json) {
    return VvsResponseMensagem.fromMap(jsonDecode(json));
  }

  factory VvsResponseMensagem.ok(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.sucesso);
  }

  factory VvsResponseMensagem.alerta(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.alerta);
  }
  factory VvsResponseMensagem.erro(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.erro);
  }
  factory VvsResponseMensagem.erroCritico(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.erroCritico);
  }
  factory VvsResponseMensagem.erroPermissaoNegada(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.erroPermissaoNegada);
  }
  factory VvsResponseMensagem.info(String mensagem) {
    return VvsResponseMensagem(texto: mensagem, tipo: TipoMensagem.info);
  }

  @override
  List<Object?> get props => [texto, tipo];
}
