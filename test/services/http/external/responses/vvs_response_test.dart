import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/vvs_core.dart';
import 'dart:convert';

final vvsResponseMock = VvsResponse<String>.ok(
  "2022-05-05T14:42:22.1856096-03:00",
  [
    VvsResponseMensagem.ok('Keep alive is ok'),
  ],
);

const vvsResponseMapMock = <String, dynamic>{
  "Value": "2022-05-05T14:42:22.1856096-03:00",
  "HasValue": true,
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

void main() {
  test('Deve retornar um VvsResponse a partir de um Map', () {
    var map = {...vvsResponseMapMock};
    var response = VvsResponse<String>.fromMap(map);

    expect(response, isA<VvsResponse<String>>());
    expect(response, vvsResponseMock);
  });

  test('Deve retornar um VvsResponse a partir de uma String', () {
    var json = jsonEncode(vvsResponseMapMock);
    var response = VvsResponse<String>.fromJson(json);

    expect(response, isA<VvsResponse<String>>());
    expect(response, vvsResponseMock);
  });

  test('Deve retornar um VvsResponse com sucesso', () {
    var response = VvsResponse.ok();

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
  });
  test('Deve retornar um VvsResponse vazio', () {
    var response = VvsResponse.vazio();

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
  });
  test('Deve retornar um VvsResponse com alerta', () {
    var response = VvsResponse.comAlerta('Test with alert!', outrasMensagens: const ['Other']);

    expect(response.ok, true);
    expect(response.hasAlerta, true);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsResponse com erro', () {
    var response = VvsResponse.erro('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsResponse com erro de permissão negada', () {
    var response = VvsResponse.erroPermissaoNegada('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, true);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsResponse com erro critico', () {
    var response = VvsResponse.erroCritico('Test with error!', outrasMensagens: const ['Other']);

    expect(response.ok, false);
    expect(response.hasAlerta, false);
    expect(response.hasError, true);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, false);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsResponse com informação', () {
    var response = VvsResponse.info('Test with info!', outrasMensagens: const ['Other']);

    expect(response.ok, true);
    expect(response.hasAlerta, false);
    expect(response.hasError, false);
    expect(response.hasErrorPermissao, false);
    expect(response.hasInfo, true);
    expect(response.mensagens.length, 2);
  });
  test('Deve retornar um VvsResponse a partir de um HttpResponse', () {
    const httpResponse = HttpResponse(
      data: vvsResponseMapMock,
      statusCode: 200,
    );
    var response = VvsResponse<String>.fromHttpResponse(httpResponse);

    expect(response, vvsResponseMock);
  });
}
