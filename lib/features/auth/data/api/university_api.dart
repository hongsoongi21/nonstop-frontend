import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../dto/university_response_dto.dart';

abstract class UniversityApi {
  Future<List<UniversityResponseDto>> getUniversities({
    String? keyword,
    String? region,
  });

  Future<UniversityResponseDto> getUniversityById(int id);
}

class UniversityApiImpl implements UniversityApi {
  final DioClient _dioClient;

  UniversityApiImpl(this._dioClient);

  @override
  Future<List<UniversityResponseDto>> getUniversities({
    String? keyword,
    String? region,
  }) async {
    try {
      final response = await _dioClient.get(
        '/api/v1/universities',
        queryParameters: {
          if (keyword != null) 'keyword': keyword,
          if (region != null) 'region': region,
        },
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final List<dynamic> data = apiResponse['data'];
        return data
            .map((json) => UniversityResponseDto.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '대학교 목록을 불러오는데 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<UniversityResponseDto> getUniversityById(int id) async {
    try {
      final response = await _dioClient.get('/api/v1/universities/$id');

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return UniversityResponseDto.fromJson(apiResponse['data']);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '대학교 정보를 불러오는데 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return ServerException(
          message: data['message'] ?? '서버 오류가 발생했습니다.',
          statusCode: e.response?.statusCode ?? 500,
        );
      }
    }
    return NetworkException('인터넷 연결을 확인해주세요.');
  }
}
