import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../dto/semester_dto.dart';
import '../dto/timetable_dto.dart';
import '../dto/timetable_entry_dto.dart';

final timetableApiProvider = Provider<TimetableApi>((ref) {
  return TimetableApiImpl(ref.read(supabaseClientProvider));
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

/// Implementation of TimetableApi using Supabase PostgREST
class TimetableApiImpl implements TimetableApi {
  final SupabaseClient _supabase;

  TimetableApiImpl(this._supabase);

  // ---------------------------------------------------------------------------
  // Helper: get current user's BIGSERIAL id from auth UUID
  // ---------------------------------------------------------------------------
  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw const ApiException('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  // ---------------------------------------------------------------------------
  // Semesters
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<SemesterDto>>> getSemesters() async {
    try {
      final data = await _supabase
          .from('semesters')
          .select()
          .order('year', ascending: false)
          .order('type');

      final now = DateTime.now();
      final currentYear = _getCurrentAcademicYear(now);
      final currentType = _getCurrentSemesterType(now);

      final list = (data as List)
          .map((json) => SemesterDto(
                id: json['id'] as int,
                year: json['year'] as int,
                type: _parseSemesterType(json['type'] as String),
                isCurrent: json['year'] == currentYear &&
                    json['type'] == _semesterTypeToDbString(currentType),
              ))
          .toList();

      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Timetables
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<TimetableDto>>> getMyTimetables() async {
    try {
      final currentUserId = await _getCurrentUserId();

      final data = await _supabase
          .from('time_tables')
          .select('*, semesters(year, type)')
          .eq('user_id', currentUserId);

      final list =
          (data as List).map((json) => _mapToTimetableDto(json)).toList();
      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableDto>> createTimetable(
    TimetableRequestDto request,
  ) async {
    try {
      final currentUserId = await _getCurrentUserId();

      // Resolve semester id from year + type
      int? semesterId;
      if (request.year != null && request.semesterType != null) {
        final semesterTypeStr = _semesterTypeToDbString(request.semesterType!);

        final semester = await _supabase
            .from('semesters')
            .select('id')
            .eq('year', request.year!)
            .eq('type', semesterTypeStr)
            .maybeSingle();

        if (semester != null) {
          semesterId = semester['id'] as int;
        } else {
          // Create semester - get user's university_id
          final user = await _supabase
              .from('users')
              .select('university_id')
              .eq('id', currentUserId)
              .single();
          final universityId = user['university_id'] as int?;
          if (universityId == null) {
            return left(const ApiException('Please set your university in Profile settings to create a timetable'));
          }

          final newSemester = await _supabase
              .from('semesters')
              .insert({
                'university_id': universityId,
                'year': request.year!,
                'type': semesterTypeStr,
              })
              .select('id')
              .single();
          semesterId = newSemester['id'] as int;
        }
      }

      if (semesterId == null) {
        return left(const ApiException('Could not determine semester'));
      }

      final result = await _supabase
          .from('time_tables')
          .insert({
            'user_id': currentUserId,
            'semester_id': semesterId,
            'title': request.title,
            'is_public': request.isPublic ?? false,
            'timetable_kind': request.timetableKind ?? 'backup',
          })
          .select('*, semesters(year, type)')
          .single();

      return right(_mapToTimetableDto(result));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, TimetableDetailDto>> getTimetableDetail(
    int id,
  ) async {
    try {
      final data = await _supabase
          .from('time_tables')
          .select('*, semesters(year, type), time_table_entries(*)')
          .eq('id', id)
          .single();

      return right(_mapToTimetableDetailDto(data));
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
      final updateData = <String, dynamic>{};
      if (request.title != null) updateData['title'] = request.title;
      if (request.isPublic != null) updateData['is_public'] = request.isPublic;
      if (request.timetableKind != null) {
        updateData['timetable_kind'] = request.timetableKind;
      }

      final result = await _supabase
          .from('time_tables')
          .update(updateData)
          .eq('id', id)
          .select('*, semesters(year, type)')
          .single();

      return right(_mapToTimetableDto(result));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteTimetable(int id) async {
    try {
      await _supabase.from('time_tables').delete().eq('id', id);
      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Entries
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, TimetableEntryDto>> addEntry(
    int timetableId,
    TimetableEntryRequestDto request,
  ) async {
    try {
      final result = await _supabase
          .from('time_table_entries')
          .insert({
            'time_table_id': timetableId,
            'subject_name': request.subjectName,
            'professor': request.professor,
            'day_of_week': request.dayOfWeek.toJson(),
            'start_time': request.startTime,
            'end_time': request.endTime,
            'place': request.place,
            'color': request.color,
            'credit': request.credit,
          })
          .select()
          .single();

      return right(_mapToEntryDto(result));
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
      final result = await _supabase
          .from('time_table_entries')
          .update({
            'subject_name': request.subjectName,
            'professor': request.professor,
            'day_of_week': request.dayOfWeek.toJson(),
            'start_time': request.startTime,
            'end_time': request.endTime,
            'place': request.place,
            'color': request.color,
            'credit': request.credit,
          })
          .eq('id', entryId)
          .select()
          .single();

      return right(_mapToEntryDto(result));
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> deleteEntry(int entryId) async {
    try {
      await _supabase.from('time_table_entries').delete().eq('id', entryId);
      return right(unit);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Public Timetables
  // ---------------------------------------------------------------------------
  @override
  Future<Either<ApiException, List<TimetableDto>>> getPublicTimetables() async {
    try {
      final data = await _supabase
          .from('time_tables')
          .select('*, semesters(year, type)')
          .eq('is_public', true);

      final list =
          (data as List).map((json) => _mapToTimetableDto(json)).toList();
      return right(list);
    } catch (e) {
      return left(ApiException(e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  SemesterType _parseSemesterType(String type) {
    switch (type) {
      case 'FIRST':
        return SemesterType.first;
      case 'SECOND':
        return SemesterType.second;
      case 'SUMMER':
        return SemesterType.summer;
      case 'WINTER':
        return SemesterType.winter;
      default:
        return SemesterType.first;
    }
  }

  String _semesterTypeToDbString(SemesterType type) {
    switch (type) {
      case SemesterType.first:
        return 'FIRST';
      case SemesterType.second:
        return 'SECOND';
      case SemesterType.summer:
        return 'SUMMER';
      case SemesterType.winter:
        return 'WINTER';
    }
  }

  /// Determine the current academic year based on current date.
  /// Korean academic calendar: year starts March.
  /// Mar-Dec → that year, Jan-Feb → previous year.
  static int _getCurrentAcademicYear(DateTime now) {
    return now.month <= 2 ? now.year - 1 : now.year;
  }

  /// Determine the current semester type based on current date.
  /// FIRST (1학기): March - August
  /// SECOND (2학기): September - February
  static SemesterType _getCurrentSemesterType(DateTime now) {
    if (now.month >= 3 && now.month <= 8) return SemesterType.first;
    return SemesterType.second;
  }

  TimetableDto _mapToTimetableDto(Map<String, dynamic> json) {
    final semesterData = json['semesters'] as Map<String, dynamic>?;
    return TimetableDto(
      id: json['id'] as int,
      semesterId: json['semester_id'] as int,
      year: semesterData?['year'] as int? ?? 0,
      semesterType:
          _parseSemesterType(semesterData?['type'] as String? ?? 'FIRST'),
      title: json['title'] as String?,
      isPublic: json['is_public'] as bool? ?? false,
      timetableKind: json['timetable_kind'] as String? ?? 'backup',
    );
  }

  TimetableDetailDto _mapToTimetableDetailDto(Map<String, dynamic> json) {
    final semesterData = json['semesters'] as Map<String, dynamic>?;
    final entriesData = json['time_table_entries'] as List? ?? [];

    return TimetableDetailDto(
      id: json['id'] as int,
      semesterId: json['semester_id'] as int,
      year: semesterData?['year'] as int? ?? 0,
      semesterType:
          _parseSemesterType(semesterData?['type'] as String? ?? 'FIRST'),
      title: json['title'] as String?,
      isPublic: json['is_public'] as bool? ?? false,
      timetableKind: json['timetable_kind'] as String? ?? 'backup',
      entries: entriesData
          .map((e) => _mapToEntryDto(e as Map<String, dynamic>))
          .toList(),
    );
  }

  TimetableEntryDto _mapToEntryDto(Map<String, dynamic> json) {
    // Supabase returns TIME as "HH:MM:SS" - convert to "HH:mm"
    String formatTime(String? time) {
      if (time == null) return '09:00';
      final parts = time.split(':');
      if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
      return time;
    }

    return TimetableEntryDto(
      id: json['id'] as int,
      timetableId: json['time_table_id'] as int,
      subjectName: json['subject_name'] as String? ?? '',
      professor: json['professor'] as String?,
      dayOfWeek:
          DayOfWeekJson.fromJson(json['day_of_week'] as String? ?? 'MONDAY'),
      startTime: formatTime(json['start_time'] as String?),
      endTime: formatTime(json['end_time'] as String?),
      place: json['place'] as String?,
      color: json['color'] as String?,
      credit: json['credit'] as int?,
    );
  }
}
