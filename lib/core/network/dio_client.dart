import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env_config.dart';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart'; // Corrected import path
import '../utils/logger.dart';
// import '../services/secure_storage_service.dart'; // Removed duplicate import

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(ref.read(secureStorageServiceProvider));
});

/// 인증 및 로깅을 위한 인터셉터가 포함된 Dio 기반 HTTP 클라이언트
class DioClient {
  late final Dio _dio;
  final SecureStorageService _secureStorageService;

  DioClient(this._secureStorageService) {
    _dio = Dio(_createBaseOptions());

    // 인터셉터 추가
    _dio.interceptors.addAll([
      _AuthInterceptor(_secureStorageService, _dio), // Pass _dio for retry
      _ResponseCheckInterceptor(),

      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    // 운영 환경에서 SSL 인증서 고정(Pinning) 추가
    if (EnvConfig.isProduction) {
      // TODO: SSL 인증서 고정 로직 추가
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
      },
      validateStatus: (status) => status != null && status < 500,
    );
  }

  /// GET 요청
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

  /// POST 요청
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

  /// PUT 요청
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

  /// PATCH 요청
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

  /// DELETE 요청
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

  /// 파일 다운로드
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

  /// 기본 Dio 인스턴스 반환 (고급 사용 용도)
  Dio get dio => _dio;
}

/// 인증 인터셉터
class _AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorageService;
  final Dio _dio;
  bool _isRefreshing = false;

  _AuthInterceptor(this._secureStorageService, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 보안 저장소에서 JWT 토큰을 가져와 헤더에 주입
    final token = await _secureStorageService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      AppLogger.d('🛡️ Auth Header injected');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 에러(인증 만료) 발생 시 토큰 갱신 시도
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      final refreshToken = await _secureStorageService.getRefreshToken();

      if (refreshToken != null) {
        _isRefreshing = true;
        AppLogger.w('🔄 Token expired. Attempting refresh...');

        try {
          // 토큰 갱신 API 호출용 별도 Dio 인스턴스 생성 (무한 루프 방지)
          final dio = Dio(BaseOptions(baseUrl: EnvConfig.apiBaseUrl));
          final response = await dio.post(
            '/api/v1/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final apiResponse = response.data as Map<String, dynamic>;
          if (apiResponse['success'] == true) {
            final data = apiResponse['data'];
            final newAccessToken = data['accessToken'];
            final newRefreshToken = data['refreshToken'];

            AppLogger.s('✅ Token refreshed successfully');

            // 새 토큰 저장
            await _secureStorageService.saveAccessToken(newAccessToken);
            if (newRefreshToken != null) {
              await _secureStorageService.saveRefreshToken(newRefreshToken);
            }

            // 원래 실패했던 요청 재시도
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await _dio.fetch(options);
            return handler.resolve(retryResponse);
          }
        } catch (e) {
          AppLogger.e('❌ Token refresh failed. Logging out...', e);
          // 리프레시 실패 시 로그아웃 처리 유도 (토큰 삭제)
          await _secureStorageService.deleteAllTokens();
        } finally {
          _isRefreshing = false;
        }
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

/// 로깅 인터셉터
class _LoggingInterceptor extends Interceptor {
  final JsonEncoder _jsonEncoder = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method.toUpperCase();
    final uri = options.uri.toString();

    AppLogger.n('┌── 🚀 [API REQUEST] $method');
    AppLogger.n('│ 🔗 URL: $uri');

    if (options.data != null) {
      _printFormattedBody('│ 📦 Body:', options.data);
    }
    if (options.queryParameters.isNotEmpty) {
      AppLogger.d('│ 🔍 Query: ${options.queryParameters}');
    }
    AppLogger.n('└────────────────────────────────────────────────────');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final method = response.requestOptions.method.toUpperCase();
    final path = response.requestOptions.uri.path;
    final statusCode = response.statusCode;
    final successIcon =
        (statusCode != null && statusCode >= 200 && statusCode < 300)
        ? '✅'
        : '⚠️';

    AppLogger.s('┌── $successIcon [API RESPONSE] $statusCode | $method $path');

    if (response.data != null) {
      _printFormattedBody('│ 📥 Data:', response.data);
    }
    AppLogger.s('└────────────────────────────────────────────────────');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final method = err.requestOptions.method.toUpperCase();
    final path = err.requestOptions.uri.path;
    final statusCode = err.response?.statusCode ?? 'ERROR';
    final message = err.message;

    AppLogger.e('┌── ❌ [API ERROR] $statusCode | $method $path');
    AppLogger.e('│ 📝 Message: $message');

    if (err.response?.data != null) {
      _printFormattedBody('│ 📦 Error Data:', err.response?.data);
    }
    AppLogger.e('└────────────────────────────────────────────────────');

    super.onError(err, handler);
  }

  void _printFormattedBody(String prefix, dynamic data) {
    if (data == null) return;

    if (data is String) {
      // HTML 감지
      if (data.trim().toLowerCase().startsWith('<!doctype html') ||
          data.trim().toLowerCase().startsWith('<html')) {
        // Title 추출 시도
        final titleMatch = RegExp(
          r'<title>(.*?)</title>',
          caseSensitive: false,
          dotAll: true,
        ).firstMatch(data);
        final title = titleMatch?.group(1)?.trim() ?? 'No Title';

        AppLogger.w('$prefix [HTML RESPONSE DETECTED]');
        AppLogger.d('│    📄 Page Title: "$title"');
        AppLogger.d(
          '│    📄 Preview: ${data.substring(0, min(data.length, 100)).replaceAll('\n', ' ')}...',
        );
        return;
      }

      // 일반 문자열
      AppLogger.d('$prefix $data');
    } else if (data is Map || data is List) {
      // JSON Pretty Print
      try {
        final prettyJson = _jsonEncoder.convert(data);
        // 너무 길면 줄바꿈 처리해서 출력하거나, AppLogger에 맡김.
        // 여기서는 가독성을 위해 첫 줄 뒤에 내용을 붙입니다.
        // AppLogger가 긴 내용을 처리한다고 가정하고 통째로 넘기되,
        // 박스 라인을 맞추기 위해 줄바꿈을 처리할 수도 있습니다.
        // 단순하게 갑니다.
        AppLogger.d('$prefix $prettyJson');
      } catch (e) {
        AppLogger.d('$prefix $data');
      }
    } else {
      AppLogger.d('$prefix $data');
    }
  }
}

/// 에러 표준화를 위한 인터셉터
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 에러 형식 표준화
    final errorData = {
      'message': err.message ?? 'Unknown error',
      'statusCode': err.response?.statusCode,
      'data': err.response?.data,
      'type': err.type.toString(),
    };

    // 표준화된 응답 생성
    final standardizedResponse = Response(
      requestOptions: err.requestOptions,
      statusCode: err.response?.statusCode ?? 500,
      statusMessage: err.message,
      data: errorData,
    );

    // 표준화된 응답으로 에러 교체
    final standardizedError = DioException(
      requestOptions: err.requestOptions,
      response: standardizedResponse,
      type: err.type,
      error: err.error,
    );

    super.onError(standardizedError, handler);
  }
}
