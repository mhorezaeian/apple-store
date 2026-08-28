abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? body;
  AppException({required this.message, this.statusCode, this.body});
}

class ApiException extends AppException {
  ApiException({required super.message, required super.statusCode, super.body});

  @override
  String toString() {
    return 'ApiException(code: $statusCode, message: $message, body: $body)';
  }
}

class NetworkException extends AppException {
  NetworkException({required super.message});
}

class UnauthorizedException extends AppException {
  UnauthorizedException({required super.message, super.statusCode});
}

class UnKnownException extends AppException {
  UnKnownException({required super.message});
}
