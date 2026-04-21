import 'package:freezed_annotation/freezed_annotation.dart';

import 'home_notice.dart';
import 'today_timetable.dart';
import 'popular_board_item.dart';

part 'home_dashboard.freezed.dart';

@freezed
class HomeDashboard with _$HomeDashboard {
  const factory HomeDashboard({
    required String weekday,
    @Default([]) List<HomeNotice> notices,
    required TodayTimetable todayTimetable,
    @Default([]) List<PopularBoardItem> popularBoards,
  }) = _HomeDashboard;
}
