import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../dto/semester_dto.dart';
import '../dto/timetable_dto.dart';
import '../dto/timetable_entry_dto.dart';

final timetableApiProvider = Provider<TimetableApi>((ref) {
  return TimetableApiImpl(ref.read(dioClientProvider));
});

/// API interface for timetable operations
abstract class TimetableApi {
  // Semester operations
  Future<Either<ApiException, List<SemesterDto>>> getSemesters();

  // Timetable operations
  Future<Either<ApiException, List<TimetableDto>>> getMyTimetables();
  Future<Either<ApiException, TimetableDto>> createTimetable(
    TimetableRequestDto request,
  );
  Future<Either<ApiException, TimetableDetailDto>> getTimetableDetail(int id);
  Future<Either<ApiException, TimetableDto>> updateTimetable(
    int id,
    TimetableRequestDto request,
  );
  Future<Either<ApiException, Unit>> deleteTimetable(int id);

  // Entry operations
  Future<Either<ApiException, TimetableEntryDto>> addEntry(
    int timetableId,
    TimetableEntryRequestDto request,
  );
  Future<Either<ApiException, TimetableEntryDto>> updateEntry(
    int entryId,
    TimetableEntryRequestDto request,
  );
  Future<Either<ApiException, Unit>> deleteEntry(int entryId);

  // Public timetables
  Future<Either<ApiException, List<TimetableDto>>> getPublicTimetables();
}

/// Implementation of TimetableApi using Dio HTTP client
class TimetableApiImpl implements TimetableApi {
  final DioClient _dio;

  TimetableApiImpl(this._dio);

  @override
  Future<Either<ApiException, List<SemesterDto>>> getSemesters() async {
    try {
      final response = await _dio.get('/api/v1/semesters');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => SemesterDto.fromJson(json))
              .toList();
          return right(list);
        }
      }

      return left(ApiException('Failed to fetch semesters'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<TimetableDto>>> getMyTimetables() async {
    try {
      final response = await _dio.get('/api/v1/timetables');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => TimetableDto.fromJson(json))
              .toList();
          return right(list);
        }
      }

      return left(ApiException('Failed to fetch timetables'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableDto>> createTimetable(
    TimetableRequestDto request,
  ) async {
    try {
      final response = await _dio.post(
        '/api/v1/timetables',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return right(TimetableDto.fromJson(data['data']));
        }
      }

      return left(ApiException('Failed to create timetable'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableDetailDto>> getTimetableDetail(
    int id,
  ) async {
    try {
      final response = await _dio.get('/api/v1/timetables/$id');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return right(TimetableDetailDto.fromJson(data['data']));
        }
      }

      return left(ApiException('Failed to fetch timetable detail'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableDto>> updateTimetable(
    int id,
    TimetableRequestDto request,
  ) async {
    try {
      final response = await _dio.patch(
        '/api/v1/timetables/$id',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return right(TimetableDto.fromJson(data['data']));
        }
      }

      return left(ApiException('Failed to update timetable'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteTimetable(int id) async {
    try {
      final response = await _dio.delete('/api/v1/timetables/$id');

      if (response.statusCode == 200) {
        return right(unit);
      }

      return left(ApiException('Failed to delete timetable'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableEntryDto>> addEntry(
    int timetableId,
    TimetableEntryRequestDto request,
  ) async {
    try {
      final response = await _dio.post(
        '/api/v1/timetables/$timetableId/entries',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return right(TimetableEntryDto.fromJson(data['data']));
        }
      }

      return left(ApiException('Failed to add entry'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableEntryDto>> updateEntry(
    int entryId,
    TimetableEntryRequestDto request,
  ) async {
    try {
      final response = await _dio.patch(
        '/api/v1/timetables/entries/$entryId',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return right(TimetableEntryDto.fromJson(data['data']));
        }
      }

      return left(ApiException('Failed to update entry'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteEntry(int entryId) async {
    try {
      final response = await _dio.delete('/api/v1/timetables/entries/$entryId');

      if (response.statusCode == 200) {
        return right(unit);
      }

      return left(ApiException('Failed to delete entry'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, List<TimetableDto>>> getPublicTimetables() async {
    try {
      final response = await _dio.get('/api/v1/timetables/public');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          final list = (data['data'] as List)
              .map((json) => TimetableDto.fromJson(json))
              .toList();
          return right(list);
        }
      }

      return left(ApiException('Failed to fetch public timetables'));
    } on DioException catch (e) {
      return left(ApiException(e.message ?? 'Network error'));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }
}
