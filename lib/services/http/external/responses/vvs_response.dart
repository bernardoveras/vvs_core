import 'dart:convert';
import '../../infra/http_response.dart';
import '../errors/http_exception.dart';
import 'vvs_response_mensagem.dart';
import 'vvs_void_response.dart';

// ignore: must_be_immutable
class VvsResponse<T> extends VvsVoidResponse {
  VvsResponse({
    this.value,
    super.mensagens = const [],
  });

  final T? value;

  bool get hasValue => value != null;

  factory VvsResponse.ok([T? value, List<VvsResponseMensagem> mensagens = const []]) {
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.vazio() {
    return VvsResponse();
  }

  factory VvsResponse.comAlerta(String mensagem, {T? value, List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.alerta(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.alerta(e)),
    ];
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.erro(String mensagem, {T? value, List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erro(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erro(e)),
    ];
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.erroPermissaoNegada(String mensagem, {T? value, List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erroPermissaoNegada(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erroPermissaoNegada(e)),
    ];
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.erroCritico(String mensagem, {T? value, List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.erroCritico(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.erroCritico(e)),
    ];
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.info(String mensagem, {T? value, List<String>? outrasMensagens}) {
    final mensagens = <VvsResponseMensagem>[
      VvsResponseMensagem.info(mensagem),
      ...?outrasMensagens?.map((e) => VvsResponseMensagem.info(e)),
    ];
    return VvsResponse(value: value, mensagens: mensagens);
  }

  factory VvsResponse.fromMap(Map<String, dynamic> map) {
    return VvsResponse(
      value: map['Value'] as T?,
      mensagens: map['Mensagens'] == null ? [] : (map['Mensagens'] as List).map((e) => VvsResponseMensagem.fromMap(e)).toList(),
    );
  }

  factory VvsResponse.fromJson(String json) => VvsResponse.fromMap(jsonDecode(json));

  factory VvsResponse.fromHttpResponse(HttpResponse response) {
    return VvsResponse.fromMap(response.data);
  }

  factory VvsResponse.fromHttpError(HttpError response) {
    Map<String, dynamic>? messageMap;
    final String message = response.message ?? 'Ocorreu um erro inesperado.';

    try {
      messageMap = jsonDecode(message);
    } catch (e) {
      messageMap = null;
    }

    return messageMap != null ? VvsResponse.fromMap(messageMap) : VvsResponse.erro(message);
  }

  @override
  List<Object?> get props => [...super.props, value];
}
