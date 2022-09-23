import 'http_response.dart';

abstract class IHttpClient {
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  });
}
