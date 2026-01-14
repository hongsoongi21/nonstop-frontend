/// Custom exceptions for the application
library;

class ServerException implements Exception {
  final String message;
  final int statusCode;

  const ServerException({required this.message, required this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

class ValidationException extends ApiException {
  final Map<String, String> errors;

  const ValidationException({required String message, this.errors = const {}})
    : super(message);

  @override
  String toString() => 'ValidationException: $message';
}

class AuthenticationException extends ApiException {
  const AuthenticationException(super.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

class AuthorizationException extends ApiException {
  const AuthorizationException(super.message);

  @override
  String toString() => 'AuthorizationException: $message';
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message);

  @override
  String toString() => 'NotFoundException: $message';
}

class TimeoutException extends ApiException {
  const TimeoutException(super.message);

  @override
  String toString() => 'TimeoutException: $message';
}
