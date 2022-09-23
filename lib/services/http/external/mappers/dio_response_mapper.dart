import 'dart:convert';

import 'package:dio/dio.dart';

import '../../infra/http_response.dart';

class DioResponseMapper {
  const DioResponseMapper._();

  static HttpResponse toHttpResponse(Response response) {
    return HttpResponse(
      statusCode: response.statusCode,
      data: (response.data is String) ? jsonDecode(response.data) : response.data,
      statusMessage: response.statusMessage,
      headers: response.headers.map,
    );
  }
}
