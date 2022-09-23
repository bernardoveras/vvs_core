import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'tipo_mensagem.dart';
import 'vvs_response_mensagem.dart';

// ignore: must_be_immutable
class VvsVoidResponse extends Equatable {
  VvsVoidResponse({
    this.mensagens = const [],
  });

  late List<VvsResponseMensagem> mensagens;

  VvsVoidResponse addMensagem(VvsResponseMensagem mensagem) {
    mensagens = [...mensagens, mensagem];
    return this;
  }

  bool get ok => !hasError;
  bool get hasAlerta => mensagens.any((msg) => msg.tipo == TipoMensagem.alerta);
  bool get hasError => mensagens.any(
        (msg) => msg.tipo == TipoMensagem.erro || msg.tipo == TipoMensagem.erroCritico || msg.tipo == TipoMensagem.erroPermissaoNegada,
      );
  bool get hasErrorPermissao => mensagens.any((msg) => msg.tipo == TipoMensagem.erroPermissaoNegada);
  bool get hasInfo => mensagens.any((msg) => msg.tipo == TipoMensagem.info);

  factory VvsVoidResponse.ok([List<VvsResponseMensagem> mensagens = const []]) {
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.vazio() {
    return VvsVoidResponse();
  }

  factory VvsVoidResponse.comAlerta(String mensagem, {List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.alerta(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.alerta(e)),
    ];
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.erro(String mensagem, {List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erro(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erro(e)),
    ];
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.erroPermissaoNegada(String mensagem, {List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erroPermissaoNegada(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erroPermissaoNegada(e)),
    ];
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.erroCritico(String mensagem, {List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erroCritico(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erroCritico(e)),
    ];
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.info(String mensagem, {List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.info(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.info(e)),
    ];
    return VvsVoidResponse(mensagens: mensagens);
  }

  factory VvsVoidResponse.fromMap(Map<String, dynamic> map) {
    return VvsVoidResponse(
      mensagens: map['Mensagens'] == null ? [] : (map['Mensagens'] as List).map((e) => VvsResponseMensagem.fromMap(e)).toList(),
    );
  }

  factory VvsVoidResponse.fromJson(String json) => VvsVoidResponse.fromMap(jsonDecode(json));

  @override
  List<Object?> get props => [mensagens];
}
