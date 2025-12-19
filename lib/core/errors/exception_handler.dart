import 'dart:io';

import 'package:dio/dio.dart';

import 'failures.dart';

/// Central exception handler that converts exceptions to domain failures
class ExceptionHandler {
  /// Convert any exception to a domain Failure
  static Failure handle(Exception exception) {
    if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is SocketException) {
      return const Failure.network(
        message: 'No internet connection. Please check your network.',
        code: 'NO_INTERNET',
      );
    } else if (exception is FormatException) {
      return const Failure.unknown(
        message: 'Invalid data format received from server.',
      );
    } else if (exception is HandshakeException) {
      return const Failure.network(
        message: 'Secure connection failed. Please try again.',
        code: 'SSL_ERROR',
      );
    } else {
      return Failure.unknown(
        message: 'An unexpected error occurred.',
        error: exception,
      );
    }
  }

  /// Handle Dio-specific exceptions
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.timeout(
          message: 'Request timed out. Please try again.',
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final message =
            exception.response?.data?['message'] as String? ??
            'Server error occurred.';

        if (statusCode == 401) {
          return Failure.authentication(message: message, code: 'UNAUTHORIZED');
        } else if (statusCode == 403) {
          return Failure.authorization(message: message, code: 'FORBIDDEN');
        } else if (statusCode == 400) {
          // Try to extract validation errors
          final errors =
              exception.response?.data?['errors'] as Map<String, dynamic>?;
          if (errors != null) {
            final fieldErrors = <String, String>{};
            errors.forEach((key, value) {
              fieldErrors[key] = value.toString();
            });
            return Failure.validation(message: message, errors: fieldErrors);
          }
          return Failure.validation(message: message);
        } else if (statusCode != null && statusCode >= 500) {
          return Failure.server(
            message: message,
            statusCode: statusCode,
            code: 'SERVER_ERROR',
          );
        } else {
          return Failure.server(
            message: message,
            statusCode: statusCode ?? 500,
          );
        }

      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const Failure.network(
          message: 'Certificate verification failed.',
          code: 'CERTIFICATE_ERROR',
        );

      case DioExceptionType.connectionError:
      default:
        return const Failure.network(
          message: 'Network connection failed. Please check your internet.',
          code: 'CONNECTION_ERROR',
        );
    }
  }
}
