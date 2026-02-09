import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../dto/report_dto.dart';
import 'report_api.dart';

final reportApiProvider = Provider<ReportApi>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportApiImpl(dioClient);
});

class ReportApiImpl implements ReportApi {
  final DioClient _dioClient;

  ReportApiImpl(this._dioClient);

  @override
  Future<Either<ApiException, void>> reportPost({
    required int postId,
    required ReportRequestDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/posts/$postId/report',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '게시글 신고에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, void>> reportComment({
    required int commentId,
    required ReportRequestDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/comments/$commentId/report',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '댓글 신고에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, void>> reportUser({
    required int userId,
    required ReportRequestDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/users/$userId/report',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '사용자 신고에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, void>> reportChatMessage({
    required int messageId,
    required ReportRequestDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/chat/messages/$messageId/report',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '채팅 메시지 신고에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  ApiException _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return ApiException(
          data['message'] ?? '서버 오류가 발생했습니다',
        );
      }
      return const ApiException('서버 오류가 발생했습니다');
    }
    return const ApiException('인터넷 연결을 확인해주세요.');
  }
}
