import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../dto/friend_dto.dart';
import 'friend_api.dart';

final friendApiProvider = Provider<FriendApi>((ref) {
  return FriendApiImpl(ref.read(dioClientProvider));
});

class FriendApiImpl implements FriendApi {
  final DioClient _dio;

  FriendApiImpl(this._dio);

  @override
  Future<Either<ApiException, List<FriendDto>>> getFriends() async {
    try {
      final response = await _dio.get('/api/v1/friends');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => FriendDto.fromJson(json))
              .toList();
          return right(list);
        }
      }
      return left(ApiException('Failed to fetch friends'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<FriendDto>>> getFriendRequests() async {
    try {
      final response = await _dio.get('/api/v1/friends/requests');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => FriendDto.fromJson(json))
              .toList();
          return right(list);
        }
      }
      return left(ApiException('Failed to fetch friend requests'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> requestFriend(String userId) async {
    try {
      final response = await _dio.post('/api/v1/friends/request/$userId');

      if (response.statusCode == 200) {
        return right(unit);
      }
      return left(ApiException('Failed to send friend request'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> acceptFriend(String userId) async {
    try {
      final response = await _dio.post('/api/v1/friends/accept/$userId');

      if (response.statusCode == 200) {
        return right(unit);
      }
      return left(ApiException('Failed to accept friend request'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteFriend(String userId) async {
    try {
      final response = await _dio.delete('/api/v1/friends/$userId');

      if (response.statusCode == 200) {
        return right(unit);
      }
      return left(ApiException('Failed to remove friend'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<FriendDto>>> searchUsers(
    String query,
  ) async {
    try {
      final response = await _dio.get(
        '/api/v1/users/search',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => FriendDto.fromJson(json))
              .toList();
          return right(list);
        }
      }
      return left(ApiException('Failed to search users'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }
}
