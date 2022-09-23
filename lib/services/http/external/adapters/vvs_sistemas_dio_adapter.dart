import '../../infra/http_client.dart';
import '../errors/http_exception.dart';
import '../responses/vvs_response.dart';

abstract class IVvsSistemasDioAdapter {
  Future<VvsResponse<T>> get<T>(
    String route, {
    Map<String, dynamic>? headers,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });

  Future<VvsResponse<T>> post<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });

  Future<VvsResponse<T>> put<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });

  Future<VvsResponse<T>> delete<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });
}

class VvsSistemasDioAdapter implements IVvsSistemasDioAdapter {
  VvsSistemasDioAdapter(this._client);

  final IHttpClient _client;

  String _generateBaseUrlWithRoute(String route, {required String baseUrl}) {
    String _baseUrlWithoutBar = baseUrl;

    if (baseUrl.substring(baseUrl.length - 1) == '/') {
      _baseUrlWithoutBar = baseUrl.substring(0, baseUrl.length - 1);
    }

    return '$_baseUrlWithoutBar/$route';
  }

  @override
  Future<VvsResponse<T>> get<T>(
    String route, {
    Map<String, dynamic>? headers,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.get(
        _generateBaseUrlWithRoute(route, baseUrl: baseUrl),
        headers: headers,
        maxRedirects: maxRedirects,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        queryParameters: queryParameters,
      );

      return VvsResponse<T>.fromHttpResponse(response);
    } on HttpError catch (e) {
      return VvsResponse<T>.erro(e.message ?? 'Ocorreu um erro inesperado.');
    } catch (e) {
      return VvsResponse<T>.erro(e.toString());
    }
  }

  @override
  Future<VvsResponse<T>> post<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.post(
        _generateBaseUrlWithRoute(route, baseUrl: baseUrl),
        body: body,
        headers: headers,
        maxRedirects: maxRedirects,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        queryParameters: queryParameters,
      );

      return VvsResponse<T>.fromHttpResponse(response);
    } on HttpError catch (e) {
      return VvsResponse<T>.fromHttpError(e);
    } catch (e) {
      return VvsResponse<T>.erro(e.toString());
    }
  }

  @override
  Future<VvsResponse<T>> put<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.put(
        _generateBaseUrlWithRoute(route, baseUrl: baseUrl),
        body: body,
        headers: headers,
        maxRedirects: maxRedirects,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        queryParameters: queryParameters,
      );

      return VvsResponse<T>.fromHttpResponse(response);
    } on HttpError catch (e) {
      return VvsResponse<T>.erro(e.message ?? 'Ocorreu um erro inesperado.');
    } catch (e) {
      return VvsResponse<T>.erro(e.toString());
    }
  }

  @override
  Future<VvsResponse<T>> delete<T>(
    String route, {
    Map<String, dynamic>? headers,
    dynamic body,
    required String baseUrl,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var response = await _client.delete(
        _generateBaseUrlWithRoute(route, baseUrl: baseUrl),
        headers: headers,
        body: body,
        maxRedirects: maxRedirects,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        queryParameters: queryParameters,
      );

      return VvsResponse<T>.fromHttpResponse(response);
    } on HttpError catch (e) {
      return VvsResponse<T>.erro(e.message ?? 'Ocorreu um erro inesperado.');
    } catch (e) {
      return VvsResponse<T>.erro(e.toString());
    }
  }
}
