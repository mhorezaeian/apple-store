abstract class AppException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? body;
  AppException({required this.message, this.statusCode, this.body});
}

class ServerException extends AppException {
  ServerException({
    required super.message,
    required super.statusCode,
    super.body,
  });

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

//local
class LocalStorageException implements Exception {
  final String message;
  final dynamic error;

  LocalStorageException({required this.message, this.error});

  @override
  String toString() {
    return 'LocalStorageException(message: $message, error: $error)';
  }
}

//payment
/// خطای فنی ارتباط با درگاه پرداخت (فقط در لایه Data پرتاب می‌شود).
/// const است چون در DataSource به شکل `throw const PaymentException(...)`
/// داخل onTimeout استفاده می‌شود.
class PaymentException implements Exception {
  final String message;
  final dynamic error;

  const PaymentException({required this.message, this.error});

  @override
  String toString() {
    return 'PaymentException(message: $message, error: $error)';
  }
}
