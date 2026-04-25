import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_semester.dart';
import 'home_timetable_entry.dart';

part 'today_timetable.freezed.dart';

@freezed
class TodayTimetable with _$TodayTimetable {
  const TodayTimetable._();

  const factory TodayTimetable({
    int? timetableId,
    HomeSemester? semester,
    @Default([]) List<HomeTimetableEntry> entries,
  }) = _TodayTimetable;

  bool get hasTimetable => timetableId != null;
  bool get isEmpty => entries.isEmpty;
}
