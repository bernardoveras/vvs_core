
class HttpResponse {
  const HttpResponse({
    this.data,
    this.headers,
    this.statusCode,
    this.statusMessage,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  final dynamic data;

  /// Response headers.
  final Map<String, dynamic>? headers;

  /// Http status code.
  final int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  final String? statusMessage;
}
