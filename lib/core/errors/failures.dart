import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Domain layer failures - framework agnostic error types
/// Used throughout the app for consistent error handling
@freezed
class Failure with _$Failure {
  /// Network-related failures
  const factory Failure.network({required String message, String? code}) =
      NetworkFailure;

  /// Authentication failures
  const factory Failure.authentication({
    required String message,
    String? code,
  }) = AuthenticationFailure;

  /// Authorization failures (insufficient permissions)
  const factory Failure.authorization({required String message, String? code}) =
      AuthorizationFailure;

  /// Validation failures with field-specific errors
  const factory Failure.validation({
    required String message,
    @Default({}) Map<String, String> errors,
  }) = ValidationFailure;

  /// Server-side failures
  const factory Failure.server({
    required String message,
    required int statusCode,
    String? code,
  }) = ServerFailure;

  /// Timeout failures
  const factory Failure.timeout({required String message}) = TimeoutFailure;

  /// WebSocket connection failures
  const factory Failure.websocket({required String message, String? code}) =
      WebSocketFailure;

  /// Cache/storage failures
  const factory Failure.cache({required String message, String? code}) =
      CacheFailure;

  /// Local storage failures
  const factory Failure.storage({required String message, String? code}) =
      StorageFailure;

  /// Unknown/unexpected failures
  const factory Failure.unknown({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UnknownFailure;
}
