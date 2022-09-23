import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:vvs_core/services/http/external/responses/vvs_response_mensagem.dart';

const vvsResponseMensagemMapMock = <String, dynamic>{
  "Texto": "Keep alive is ok",
  "Tipo": 1,
  "DescricaoDaPermissao": null,
  "ClaimRequerida": null,
  "ValorClaimRequerida": null
};

void main() {
  test('Deve retornar um VvsResponseMensagem a partir de um Map', () {
    var map = {...vvsResponseMensagemMapMock};
    var parsedDto = VvsResponseMensagem.fromMap(map);

    expect(parsedDto, isA<VvsResponseMensagem>());
  });

  test('Deve retornar um VvsResponseMensagem a partir de uma String', () {
    var json = jsonEncode(vvsResponseMensagemMapMock);
    var parsedDto = VvsResponseMensagem.fromJson(json);

    expect(parsedDto, isA<VvsResponseMensagem>());
  });
}
