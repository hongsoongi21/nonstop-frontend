import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../data/api/timetable_api_impl.dart';
import '../../data/dto/semester_dto.dart';
import '../../data/dto/timetable_dto.dart';
import '../../data/dto/timetable_entry_dto.dart';
import '../../domain/entities/day_of_week.dart';
import '../../domain/entities/semester.dart';
import '../../domain/entities/timetable.dart';
import '../../domain/entities/timetable_entry.dart';
import '../../domain/repository/timetable_repository.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>((ref) {
  return TimetableRepositoryImpl(ref.read(timetableApiProvider));
});

class TimetableRepositoryImpl implements TimetableRepository {
  final TimetableApi _api;

  TimetableRepositoryImpl(this._api);

  @override
  Future<Either<Failure, List<Semester>>> getSemesters() async {
    final result = await _api.getSemesters();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => Semester.fromDto(dto)).toList()),
    );
  }

  @override
  Future<Either<Failure, List<Timetable>>> getMyTimetables() async {
    final result = await _api.getMyTimetables();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => Timetable.fromDto(dto)).toList()),
    );
  }

  @override
  Future<Either<Failure, Timetable>> createTimetable({
    required int year,
    required SemesterType semesterType,
    String? title,
    bool isPublic = false,
  }) async {
    final request = TimetableRequestDto(
      year: year,
      semesterType: semesterType,
      title: title,
      isPublic: isPublic,
    );
    final result = await _api.createTimetable(request);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dto) => Right(Timetable.fromDto(dto)),
    );
  }

  @override
  Future<Either<Failure, TimetableDetail>> getTimetableDetail(int id) async {
    final result = await _api.getTimetableDetail(id);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dto) => Right(TimetableDetail.fromDto(dto)),
    );
  }

  @override
  Future<Either<Failure, Timetable>> updateTimetable({
    required int id,
    String? title,
    bool? isPublic,
  }) async {
    final request = TimetableRequestDto(title: title, isPublic: isPublic);
    final result = await _api.updateTimetable(id, request);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dto) => Right(Timetable.fromDto(dto)),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteTimetable(int id) async {
    final result = await _api.deleteTimetable(id);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, TimetableEntry>> addEntry({
    required int timetableId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) async {
    final request = TimetableEntryRequestDto(
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );
    final result = await _api.addEntry(timetableId, request);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dto) => Right(TimetableEntry.fromDto(dto)),
    );
  }

  @override
  Future<Either<Failure, TimetableEntry>> updateEntry({
    required int entryId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) async {
    final request = TimetableEntryRequestDto(
      subjectName: subjectName,
      professor: professor,
      dayOfWeek: dayOfWeek,
      startTime: startTime,
      endTime: endTime,
      place: place,
      color: color,
    );
    final result = await _api.updateEntry(entryId, request);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dto) => Right(TimetableEntry.fromDto(dto)),
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteEntry(int entryId) async {
    final result = await _api.deleteEntry(entryId);
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<Failure, List<Timetable>>> getPublicTimetables() async {
    final result = await _api.getPublicTimetables();
    return result.match(
      (error) => Left(ServerFailure(message: error.message, statusCode: 500)),
      (dtos) => Right(dtos.map((dto) => Timetable.fromDto(dto)).toList()),
    );
  }
}
