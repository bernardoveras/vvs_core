import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/http_exception.dart';

import '../../infra/http_client.dart';
import '../../infra/http_response.dart';
import '../mappers/dio_response_mapper.dart';

class DioClientAdapter implements IHttpClient {
  DioClientAdapter(this._dio);

  final Dio _dio;

  Map<String, dynamic> _defaultHeader([Map<String, dynamic>? headers]) {
    return {...?headers};
  }

  String contentType(Map<String, dynamic>? headers) => headers?['content-type'] ?? headers?['Content-Type'] ?? 'application/json';

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var result = await _dio.get(
        url,
        options: Options(
          headers: _defaultHeader(headers),
          maxRedirects: maxRedirects,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
        ),
        queryParameters: queryParameters,
      );

      return DioResponseMapper.toHttpResponse(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var result = await _dio.post(
        url,
        data: body == null
            ? null
            : contentType(headers) == 'application/json'
                ? jsonEncode(body)
                : body,
        options: headers != null
            ? Options(
                headers: _defaultHeader(headers),
                maxRedirects: maxRedirects,
                sendTimeout: sendTimeout,
                receiveTimeout: receiveTimeout,
              )
            : null,
        queryParameters: queryParameters,
      );

      return DioResponseMapper.toHttpResponse(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse> put(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var result = await _dio.put(
        url,
        data: body == null
            ? null
            : contentType(headers) == 'application/json'
                ? jsonEncode(body)
                : body,
        options: headers != null
            ? Options(
                headers: _defaultHeader(headers),
                maxRedirects: maxRedirects,
                sendTimeout: sendTimeout,
                receiveTimeout: receiveTimeout,
              )
            : null,
        queryParameters: queryParameters,
      );

      return DioResponseMapper.toHttpResponse(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    Map<String, dynamic>? headers,
    dynamic body,
    int maxRedirects = 5,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var result = await _dio.delete(
        url,
        data: body == null
            ? null
            : contentType(headers) == 'application/json'
                ? jsonEncode(body)
                : body,
        options: headers != null
            ? Options(
                headers: _defaultHeader(headers),
                maxRedirects: maxRedirects,
                sendTimeout: sendTimeout,
                receiveTimeout: receiveTimeout,
              )
            : null,
        queryParameters: queryParameters,
      );

      return DioResponseMapper.toHttpResponse(result);
    } catch (e) {
      throw _handleException(e);
    }
  }

  Exception _handleException(dynamic exception) {
    if (exception is Exception) {
      if (exception is DioError) {
        switch (exception.type) {
          case DioErrorType.cancel:
            return HttpError(
              message: 'Request to API server was cancelled',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.serverError,
            );
          case DioErrorType.connectTimeout:
            return HttpError(
              message: 'Connection timeout with API server',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          case DioErrorType.receiveTimeout:
            return HttpError(
              message: 'Receive timeout with API server',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          case DioErrorType.response:
            switch (exception.response?.statusCode) {
              case 400:
                return HttpError(
                  message: exception.response?.data == null
                      ? exception.response?.statusMessage ?? 'Bad request'
                      : (exception.response!.data is Map)
                          ? exception.response!.data['error'] ?? jsonEncode(exception.response!.data)
                          : exception.response!.data.toString(),
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.badRequest,
                );
              case 401:
                return HttpError(
                  message: 'Unauthorized',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.unauthorized,
                );
              case 403:
                return HttpError(
                  message: 'Forbidden',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.forbidden,
                );
              case 404:
                return HttpError(
                  message: 'Not found',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.notFound,
                );
              case 408:
                return HttpError(
                  message: 'Request timeout',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.timeout,
                );
              case 409:
                return HttpError(
                  message: 'Conflict',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              case 500:
                return HttpError(
                  message: 'Internal server error',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              case 503:
                return HttpError(
                  message: 'Service unavailable',
                  statusCode: exception.response?.statusCode,
                  errorType: HttpErrorType.serverError,
                );
              default:
                return HttpError(
                  message: exception.response?.statusMessage,
                  statusCode: exception.response?.statusCode,
                );
            }
          case DioErrorType.sendTimeout:
            return HttpError(
              message: 'Request timeout',
              statusCode: exception.response?.statusCode,
              errorType: HttpErrorType.timeout,
            );
          default:
            return HttpError(
              message: exception.response?.statusMessage,
              statusCode: exception.response?.statusCode,
            );
        }
      } else if (exception is SocketException) {
        return HttpError(
          errorType: HttpErrorType.noInternetConnection,
          message: 'No internet connection',
          statusCode: exception.osError?.errorCode,
        );
      }
    }

    return const HttpError(
      errorType: HttpErrorType.unexpected,
      message: 'Ocorreu um erro inesperado',
    );
  }
}
