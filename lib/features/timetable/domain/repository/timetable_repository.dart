import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../data/dto/semester_dto.dart';
import '../entities/day_of_week.dart';
import '../entities/semester.dart';
import '../entities/timetable.dart';
import '../entities/timetable_entry.dart';

/// Repository interface for timetable operations
/// Domain layer - framework agnostic
abstract class TimetableRepository {
  // Semester operations
  Future<Either<Failure, List<Semester>>> getSemesters();

  // Timetable operations
  Future<Either<Failure, List<Timetable>>> getMyTimetables();
  Future<Either<Failure, Timetable>> createTimetable({
    required int year,
    required SemesterType semesterType,
    String? title,
    bool isPublic = false,
  });
  Future<Either<Failure, TimetableDetail>> getTimetableDetail(int id);
  Future<Either<Failure, Timetable>> updateTimetable({
    required int id,
    String? title,
    bool? isPublic,
  });
  Future<Either<Failure, Unit>> deleteTimetable(int id);

  // Entry operations
  Future<Either<Failure, TimetableEntry>> addEntry({
    required int timetableId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  });
  Future<Either<Failure, TimetableEntry>> updateEntry({
    required int entryId,
    required String subjectName,
    String? professor,
    required DayOfWeek dayOfWeek,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  });
  Future<Either<Failure, Unit>> deleteEntry(int entryId);

  // Public timetables
  Future<Either<Failure, List<Timetable>>> getPublicTimetables();
}
