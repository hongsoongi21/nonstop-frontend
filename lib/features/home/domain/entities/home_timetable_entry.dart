import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_timetable_entry.freezed.dart';

@freezed
class HomeTimetableEntry with _$HomeTimetableEntry {
  const factory HomeTimetableEntry({
    required int id,
    String? subjectName,
    String? professor,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) = _HomeTimetableEntry;
}
