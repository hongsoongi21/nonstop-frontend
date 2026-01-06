import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/env_config.dart';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';
import '../utils/logger.dart';

/// 인증 및 로깅을 위한 인터셉터가 포함된 Dio 기반 HTTP 클라이언트
class DioClient {
  late final Dio _dio;
  final SecureStorageService _secureStorageService;

  DioClient(this._secureStorageService) {
    _dio = Dio(_createBaseOptions());

    // 인터셉터 추가
    _dio.interceptors.addAll([
      _AuthInterceptor(_secureStorageService),
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

  _AuthInterceptor(this._secureStorageService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 보안 저장소에서 JWT 토큰을 가져와 헤더에 주입
    final token = await _secureStorageService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 401 에러 시 토큰 갱신 처리
    if (err.response?.statusCode == 401) {
      // TODO: 토큰 갱신 로직 구현
      // - 토큰 갱신 시도
      // - 갱신 성공 시 원래 요청 재시도
      // - 갱신 실패 시 로그아웃 처리
    }

    super.onError(err, handler);
  }
}

/// 로깅 인터셉터
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
        resultLog('📦 Data:', response.data);
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
