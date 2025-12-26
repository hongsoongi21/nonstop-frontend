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

class ValidationException implements Exception {
  final String message;
  final Map<String, String> errors;

  const ValidationException({required this.message, this.errors = const {}});

  @override
  String toString() => 'ValidationException: $message';
}

class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

class AuthorizationException implements Exception {
  final String message;

  const AuthorizationException(this.message);

  @override
  String toString() => 'AuthorizationException: $message';
}
