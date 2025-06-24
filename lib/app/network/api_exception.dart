
class ApiException implements Exception {
  final String message;
  final String code;

  ApiException(this.message, this.code);

  @override
  String toString() {
    return 'ApiException: $message, code: $code';
  }
}

class ErrorCode {
  static const String NETWORK_ERROR = "-1";
}