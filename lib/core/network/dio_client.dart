import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env_config.dart';
import '../config/app_config.dart';
import '../utils/logger.dart';
import '../services/secure_storage_service.dart';
import 'dto/auth_response_dto.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// HTTP client using Dio with interceptors for authentication and logging
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(_createBaseOptions());

    // Add interceptors
    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _ResponseCheckInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    // Add certificate pinning in production
    if (EnvConfig.isProduction) {
      // TODO: Add SSL certificate pinning
      // _dio.httpClientAdapter = HttpClientAdapter()..onHttpClientCreate = (client) {
      //   // Configure certificate pinning
      // };
    }
  }

  BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: EnvConfig.apiBaseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      sendTimeout: AppConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // TODO: Add version headers
        // 'X-App-Version': AppConfig.appVersion,
        // 'X-Platform': Platform.operatingSystem,
      },
      validateStatus: (status) => status != null && status < 500,
    );
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// Download file
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }

  /// Update authentication token
  void updateAuthToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  /// Clear authentication
  void clearAuth() {
    _dio.options.headers.remove('Authorization');
  }

  /// Get the underlying Dio instance (for advanced usage)
  Dio get dio => _dio;
}

/// Authentication interceptor
class _AuthInterceptor extends Interceptor {
  final _storage = SecureStorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle token refresh on 401
    if (err.response?.statusCode == 401) {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        super.onError(err, handler);
        return;
      }

      try {
        // Create a new Dio instance for the refresh request to avoid interceptors
        // We use the same base URL as the original client
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: EnvConfig.apiBaseUrl,
            headers: {'Content-Type': 'application/json'},
            validateStatus: (status) => status != null && status < 500,
          ),
        );

        // Call refresh endpoint
        final refreshResponse = await refreshDio.post(
          '/api/v1/auth/refresh',
          data: {'refreshToken': refreshToken},
        );

        if (refreshResponse.statusCode == 200) {
          // Parse new tokens (API returns ApiResponse<TokenResponseDto>)
          final authResponse = AuthResponseDto.fromJson(
            refreshResponse.data['data'],
          );

          // Save new tokens
          await _storage.saveAccessToken(authResponse.accessToken);
          await _storage.saveRefreshToken(authResponse.refreshToken);

          // Retry original request with new token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer ${authResponse.accessToken}';

          final clonedRequest = await refreshDio.request(
            opts.path,
            options: Options(
              method: opts.method,
              headers: opts.headers,
              contentType: opts.contentType,
              responseType: opts.responseType,
              followRedirects: opts.followRedirects,
              validateStatus: opts.validateStatus,
              receiveTimeout: opts.receiveTimeout,
              sendTimeout: opts.sendTimeout,
              extra: opts.extra,
            ),
            data: opts.data,
            queryParameters: opts.queryParameters,
            cancelToken: opts.cancelToken,
            onReceiveProgress: opts.onReceiveProgress,
            onSendProgress: opts.onSendProgress,
          );

          handler.resolve(clonedRequest);
          return;
        } else {
          // Refresh failed
          await _storage.clearTokens();
        }
      } catch (e) {
        // Refresh error
        await _storage.clearTokens();
      }
    }

    super.onError(err, handler);
  }
}

/// Response Check Interceptor to detect HTML responses
class _ResponseCheckInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final contentType = response.headers.value('content-type');

    // Check if the response content type indicates HTML
    // Often happens when an API request is redirected to a login page (302 -> 200 OK HTML)
    if (contentType != null && contentType.contains('text/html')) {
      // Only reject if we expected JSON (default)
      if (response.requestOptions.responseType == ResponseType.json) {
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error:
                'Received HTML response instead of JSON. This likely indicates an authentication issue (redirect to login).',
          ),
          true,
        );
        return;
      }
    }
    super.onResponse(response, handler);
  }
}

/// Logging interceptor
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kReleaseMode) {
      infoLog('🌐 HTTP Request:', options.uri.toString());
      infoLog('📤 Method:', options.method);
      if (options.data != null) {
        infoLog('📦 Data:', options.data);
      }
      if (options.queryParameters.isNotEmpty) {
        infoLog('🔍 Query:', options.queryParameters);
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      resultLog('✅ HTTP Response:', response.statusCode);
      resultLog('📥 URL:', response.requestOptions.uri.toString());
      if (response.data != null) {
        // Truncate long strings (like HTML) to avoid flooding logs
        if (response.data is String && (response.data as String).length > 500) {
          resultLog(
            '📦 Data:',
            '${(response.data as String).substring(0, 500)}... (truncated)',
          );
        } else {
          resultLog('📦 Data:', response.data);
        }
      }
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kReleaseMode) {
      errLog('❌ HTTP Error:', err.message);
      errLog('🔗 URL:', err.requestOptions.uri.toString());
      if (err.response != null) {
        errLog('📊 Status:', err.response!.statusCode);
        errLog('📦 Data:', err.response!.data);
      }
    }

    super.onError(err, handler);
  }
}

/// Error interceptor for standardization
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Standardize error format
    final errorData = {
      'message': err.message ?? 'Unknown error',
      'statusCode': err.response?.statusCode,
      'data': err.response?.data,
      'type': err.type.toString(),
    };

    // Create standardized response
    final standardizedResponse = Response(
      requestOptions: err.requestOptions,
      statusCode: err.response?.statusCode ?? 500,
      statusMessage: err.message,
      data: errorData,
    );

    // Replace the error with standardized response
    final standardizedError = DioException(
      requestOptions: err.requestOptions,
      response: standardizedResponse,
      type: err.type,
      error: err.error,
    );

    super.onError(standardizedError, handler);
  }
}
