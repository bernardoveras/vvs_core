import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vvs_core/vvs_core.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final url = faker.internet.httpUrl();
  final headers = {'content-type': 'application/json; charset=utf-8', 'X-Serial': 2022};

  late final DioMock dio;
  late final DioClientAdapter client;

  setUpAll(() {
    dio = DioMock();
    client = DioClientAdapter(dio);
  });

  group('GET', () {
    test('Should succeed if the request is Ok', () async {
      var responsePayload = '{"status": "ok"}';
      var response = Response(
        requestOptions: RequestOptions(path: url, headers: headers),
        data: responsePayload,
        statusCode: 200,
      );

      when(() => dio.get(any(), options: any(named: 'options'))).thenAnswer((_) async => response);

      final result = await client.get(url, headers: headers);

      expect(result, isA<HttpResponse>());
      expect(result.data, {"status": "ok"});
      expect(result.statusCode, 200);
    });

    test('Should succeed if the request is Ok with no data', () async {
      var response = Response(
        requestOptions: RequestOptions(path: url, headers: headers),
        statusCode: 200,
      );

      when(() => dio.get(any(), options: any(named: 'options'))).thenAnswer((_) async => response);

      final result = await client.get(url, headers: headers);

      expect(result, isA<HttpResponse>());
      expect(result.data, null);
      expect(result.statusCode, 200);
    });

    test('Should error if the request is Bad request with data', () async {
      var responsePayload = {
        "Value": {
          "DataDeValidade": "2022-06-25T04:31:59.7391069+00:00",
          "CodigoDoComputador": "12323",
          "ChaveDeContrato": null,
          "VersaoDoCPlus": "4.5.8.122",
          "AtivacaoPelaCentralDoCliente": true,
          "Cnpj": "06022681000175",
          "CodigoDoCliente": "002015",
          "Uf": null,
          "ChaveDeAtivacao": "",
          "ContratoAtivo": false,
          "IdUsuarioQueSolicitouAAtivacao": "ec84730b-d139-4f37-8add-f29410283e8c",
          "AtivacaoVvs": false
        },
        "HasValue": true,
        "Mensagens": [
          {
            "Texto": "Não foram encontrados contratos ativos para gerar esta chave de ativação.",
            "Tipo": 2,
            "DescricaoDaPermissao": null,
            "ClaimRequerida": null
          }
        ],
        "Ok": false,
        "HasAlerta": false,
        "HasError": true,
        "HasErrorPermissao": false,
        "HasInfo": false
      };
      var response = DioError(
        type: DioErrorType.response,
        response: Response(
          data: responsePayload,
          requestOptions: RequestOptions(path: url, headers: headers),
          statusCode: 400,
        ),
        requestOptions: RequestOptions(path: url, headers: headers),
      );

      when(() => dio.get(any(), options: any(named: 'options'))).thenThrow(response);

      try {
        await client.get(url, headers: headers);
      } catch (error) {
        expect(error, isA<HttpError>());
        var dataDecoded = jsonDecode((error as HttpError).message ?? '');
        expect(dataDecoded, responsePayload);
        expect(error.statusCode, 400);
      }
    });
  });
}
