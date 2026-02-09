import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../dto/verification_dto.dart';
import 'verification_api.dart';

final verificationApiProvider = Provider<VerificationApi>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VerificationApiImpl(dioClient);
});

class VerificationApiImpl implements VerificationApi {
  final DioClient _dioClient;

  VerificationApiImpl(this._dioClient);

  @override
  Future<Either<ApiException, void>> uploadStudentId({
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _dioClient.post(
        '/api/v1/verification/student-id',
        data: formData,
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '학생증 업로드에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, void>> requestEmailVerification({
    required EmailVerificationRequestDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/verification/email/request',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '인증 코드 발송에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, void>> confirmEmailVerification({
    required EmailVerificationConfirmDto request,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/verification/email/confirm',
        data: request.toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return right(null);
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '이메일 인증에 실패했습니다.',
          ),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    }
  }

  @override
  Future<Either<ApiException, VerificationStatusDto>> getVerificationStatus() async {
    try {
      final response = await _dioClient.get(
        '/api/v1/users/me/verification-status',
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final data = apiResponse['data'] as Map<String, dynamic>;
        return right(VerificationStatusDto.fromJson(data));
      } else {
        return left(
          ApiException(
            apiResponse['message'] ?? '인증 상태 조회에 실패했습니다.',
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
