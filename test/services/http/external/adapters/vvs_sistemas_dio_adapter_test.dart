import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vvs_core/vvs_core.dart';

import '../responses/vvs_response_test.dart';

class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late final IHttpClient client;
  late final VvsSistemasDioAdapter adapter;
  const String baseUrl = 'http://localhost:500';

  setUpAll(() {
    client = HttpClientMock();
    adapter = VvsSistemasDioAdapter(client);
  });

  group('GET', () {
    setUp(() {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => const HttpResponse(data: vvsResponseMapMock, statusCode: 200),
      );
    });
    test('Deve retornar um VvsResponse com valor caso for sucesso', () async {
      final response = await adapter.get<String>('keepalive', baseUrl: baseUrl);

      expect(response, vvsResponseMock);
    });
    test('Deve retornar um VvsResponse com erro caso não for sucesso', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenThrow(
        const HttpError(message: 'Ocorreu um erro inesperado.'),
      );

      final response = await adapter.get<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
    });
    test('Deve fazer a requisição com os parâmetros corretos', () async {
      await adapter.get<String>('keepalive', baseUrl: baseUrl, headers: {'Content-Type': 'application/json'});

      verify(
        () => client.get(
          '$baseUrl/keepalive',
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test('Deve retornar mensagem quando receber exceção', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenThrow(
        Exception('Ocorreu um erro inesperado.'),
      );

      final response = await adapter.get<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
      expect(response.mensagens.first.texto, 'Exception: Ocorreu um erro inesperado.');
    });
  });

  group('POST', () {
    setUp(() {
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer(
        (_) async => const HttpResponse(data: vvsResponseMapMock, statusCode: 200),
      );
    });
    test('Deve retornar um VvsResponse com valor caso for sucesso', () async {
      final response = await adapter.post<String>('keepalive', body: {"key": "value"}, baseUrl: baseUrl);

      expect(response, vvsResponseMock);
    });
    test('Deve retornar um VvsResponse com erro caso não for sucesso', () async {
      when(() => client.post(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenThrow(
        const HttpError(message: 'Ocorreu um erro inesperado.'),
      );

      final response = await adapter.post<String>('keepalive', body: {"key": "value"}, baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
    });
    test('Deve fazer a requisição com os parâmetros corretos', () async {
      await adapter.post<String>('keepalive', headers: {'Content-Type': 'application/json'}, body: {"key": "value"}, baseUrl: baseUrl);

      verify(
        () => client.post(
          '$baseUrl/keepalive',
          headers: {'Content-Type': 'application/json'},
          body: {"key": "value"},
        ),
      );
    });
    test('Deve retornar mensagem quando receber exceção', () async {
      when(() => client.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(
        Exception('Ocorreu um erro inesperado.'),
      );

      final response = await adapter.post<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
      expect(response.mensagens.first.texto, 'Exception: Ocorreu um erro inesperado.');
    });
  });

  group('PUT', () {
    setUp(() {
      when(() => client.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenAnswer(
        (_) async => const HttpResponse(data: vvsResponseMapMock, statusCode: 200),
      );
    });
    test('Deve retornar um VvsResponse com valor caso for sucesso', () async {
      final response = await adapter.put<String>('keepalive', body: {"key": "value"}, baseUrl: baseUrl);

      expect(response, vvsResponseMock);
    });
    test('Deve retornar um VvsResponse com erro caso não for sucesso', () async {
      when(() => client.put(any(), headers: any(named: 'headers'), body: any(named: 'body'))).thenThrow(
        const HttpError(message: 'Ocorreu um erro inesperado.'),
      );

      final response = await adapter.put<String>('keepalive', body: {"key": "value"}, baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
    });
    test('Deve fazer a requisição com os parâmetros corretos', () async {
      await adapter.put<String>('keepalive', headers: {'Content-Type': 'application/json'}, body: {"key": "value"}, baseUrl: baseUrl);

      verify(
        () => client.put(
          '$baseUrl/keepalive',
          headers: {'Content-Type': 'application/json'},
          body: {"key": "value"},
        ),
      );
    });
    test('Deve retornar mensagem quando receber exceção', () async {
      when(() => client.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenThrow(
        Exception('Ocorreu um erro inesperado.'),
      );

      final response = await adapter.put<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
      expect(response.mensagens.first.texto, 'Exception: Ocorreu um erro inesperado.');
    });
  });

  group('DELETE', () {
    setUp(() {
      when(() => client.delete(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => const HttpResponse(data: vvsResponseMapMock, statusCode: 200),
      );
    });
    test('Deve retornar um VvsResponse com valor caso for sucesso', () async {
      final response = await adapter.delete<String>('keepalive', baseUrl: baseUrl);

      expect(response, vvsResponseMock);
    });
    test('Deve retornar um VvsResponse com erro caso não for sucesso', () async {
      when(() => client.delete(any(), headers: any(named: 'headers'))).thenThrow(
        const HttpError(message: 'Ocorreu um erro inesperado.'),
      );

      final response = await adapter.delete<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
    });
    test('Deve fazer a requisição com os parâmetros corretos', () async {
      await adapter.delete<String>('keepalive', headers: {'Content-Type': 'application/json'}, baseUrl: baseUrl);

      verify(
        () => client.delete(
          '$baseUrl/keepalive',
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });
    test('Deve retornar mensagem quando receber exceção', () async {
      when(() => client.delete(
            any(),
            headers: any(named: 'headers'),
          )).thenThrow(
        Exception('Ocorreu um erro inesperado.'),
      );

      final response = await adapter.delete<String>('keepalive', baseUrl: baseUrl);

      expect(response.ok, false);
      expect(response.hasValue, false);
      expect(response.hasError, true);
      expect(response.mensagens.first.texto, 'Exception: Ocorreu um erro inesperado.');
    });
  });
}
