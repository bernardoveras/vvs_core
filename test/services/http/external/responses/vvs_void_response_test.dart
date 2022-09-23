import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/services/http/external/responses/tipo_mensagem.dart';
import 'package:vvs_core/services/http/external/responses/vvs_response_mensagem.dart';
import 'dart:convert';

import 'package:vvs_core/services/http/external/responses/vvs_void_response.dart';

final vvsVoidResponseMapMock = {
  "Mensagens": [
    {
      "Texto": "Keep alive is ok",
      "Tipo": 1,
      "DescricaoDaPermissao": null,
      "ClaimRequerida": null,
      "ValorClaimRequerida": null,
    }
  ],
  "Ok": true,
  "HasAlerta": false,
  "HasError": false,
  "HasErrorPermissao": false,
  "HasInfo": false
};

final vvsVoidResponseMock = VvsVoidResponse(
  mensagens: [
    VvsResponseMensagem(
      texto: 'Keep alive is ok',
      tipo: 1.tipoMensagem,
    ),
  ],
);


void main() {
  test('Deve retornar um VvsVoidResponse a partir de um Map', () {
    var map = {...vvsVoidResponseMapMock};
    var response = VvsVoidResponse.fromMap(map);

    expect(response, isA<VvsVoidResponse>());
    expect(response, vvsVoidResponseMock);
  });

  test('Deve retornar um VvsVoidResponse a partir de uma String', () {
    var json = jsonEncode(vvsVoidResponseMapMock);
    var response = VvsVoidResponse.fromJson(json);

    expect(response, isA<VvsVoidResponse>());
    expect(response, vvsVoidResponseMock);
  });

  test('Deve retornar um VvsVoidResponse com sucesso', () {
    var response = VvsVoidResponse.ok();

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
  });
  test('Deve retornar um VvsVoidResponse vazio', () {
    var response = VvsVoidResponse.vazio();

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
  });
  test('Deve retornar um VvsVoidResponse com alerta', () {
    var response = VvsVoidResponse.comAlerta('Test with alert!', outrasMensagens: const ['Other']);

    expect(response.ok, true);
    expect(response.hasAlerta, true);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsVoidResponse com erro', () {
    var response = VvsVoidResponse.erro('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsVoidResponse com erro de permissão negada', () {
    var response = VvsVoidResponse.erroPermissaoNegada('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, true);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsVoidResponse com erro critico', () {
    var response = VvsVoidResponse.erroCritico('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsVoidResponse com informação', () {
    var response = VvsVoidResponse.info('Test with info!', outrasMensagens: const ['Other']);

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, true);
    expect(response.mensagens.length, 2);
  });

  test('Deve adicionar uma mensagem e retornar um VvsVoidResponse', () {
    var response = VvsVoidResponse.vazio();
    var mensagem = VvsResponseMensagem.info('Test with info!');

    response.addMensagem(mensagem);

    expect(response.ok, true);
    expect(response.mensagens.first, mensagem);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, true);
  });
}
