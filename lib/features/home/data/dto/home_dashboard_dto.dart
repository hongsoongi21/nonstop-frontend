import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/home_dashboard.dart';
import '../../domain/entities/home_notice.dart';
import '../../domain/entities/today_timetable.dart';
import '../../domain/entities/home_semester.dart';
import '../../domain/entities/home_timetable_entry.dart';
import '../../domain/entities/popular_board_item.dart';

part 'home_dashboard_dto.freezed.dart';
part 'home_dashboard_dto.g.dart';

// ---------------------------------------------------------------------------
// HomeNoticeDto
// ---------------------------------------------------------------------------

@freezed
class HomeNoticeDto with _$HomeNoticeDto {
  const factory HomeNoticeDto({
    required int id,
    String? title,
    required String createdAt,
    required int boardId,
    required String boardName,
    String? boardSlug,
  }) = _HomeNoticeDto;

  factory HomeNoticeDto.fromJson(Map<String, dynamic> json) =>
      _$HomeNoticeDtoFromJson(json);
}

extension HomeNoticeDtoX on HomeNoticeDto {
  HomeNotice toDomain() => HomeNotice(
        id: id,
        title: title,
        createdAt: DateTime.parse(createdAt),
        boardId: boardId,
        boardName: boardName,
        boardSlug: boardSlug,
      );
}

// ---------------------------------------------------------------------------
// HomeSemesterDto
// ---------------------------------------------------------------------------

@freezed
class HomeSemesterDto with _$HomeSemesterDto {
  const factory HomeSemesterDto({
    required int id,
    required int year,
    required String type,
  }) = _HomeSemesterDto;

  factory HomeSemesterDto.fromJson(Map<String, dynamic> json) =>
      _$HomeSemesterDtoFromJson(json);
}

extension HomeSemesterDtoX on HomeSemesterDto {
  HomeSemester toDomain() => HomeSemester(id: id, year: year, type: type);
}

// ---------------------------------------------------------------------------
// HomeTimetableEntryDto
// ---------------------------------------------------------------------------

@freezed
class HomeTimetableEntryDto with _$HomeTimetableEntryDto {
  const factory HomeTimetableEntryDto({
    required int id,
    String? subjectName,
    String? professor,
    required String startTime,
    required String endTime,
    String? place,
    String? color,
  }) = _HomeTimetableEntryDto;

  factory HomeTimetableEntryDto.fromJson(Map<String, dynamic> json) =>
      _$HomeTimetableEntryDtoFromJson(json);
}

extension HomeTimetableEntryDtoX on HomeTimetableEntryDto {
  HomeTimetableEntry toDomain() => HomeTimetableEntry(
        id: id,
        subjectName: subjectName,
        professor: professor,
        startTime: startTime,
        endTime: endTime,
        place: place,
        color: color,
      );
}

// ---------------------------------------------------------------------------
// TodayTimetableDto
// ---------------------------------------------------------------------------

@freezed
class TodayTimetableDto with _$TodayTimetableDto {
  const factory TodayTimetableDto({
    int? timetableId,
    HomeSemesterDto? semester,
    @Default([]) List<HomeTimetableEntryDto> entries,
  }) = _TodayTimetableDto;

  factory TodayTimetableDto.fromJson(Map<String, dynamic> json) =>
      _$TodayTimetableDtoFromJson(json);
}

extension TodayTimetableDtoX on TodayTimetableDto {
  TodayTimetable toDomain() => TodayTimetable(
        timetableId: timetableId,
        semester: semester?.toDomain(),
        entries: entries.map((e) => e.toDomain()).toList(),
      );
}

// ---------------------------------------------------------------------------
// PopularTopPostDto
// ---------------------------------------------------------------------------

@freezed
class PopularTopPostDto with _$PopularTopPostDto {
  const factory PopularTopPostDto({
    required int id,
    String? title,
    required int viewCount,
    required String createdAt,
    required int likeCount,
    required int commentCount,
  }) = _PopularTopPostDto;

  factory PopularTopPostDto.fromJson(Map<String, dynamic> json) =>
      _$PopularTopPostDtoFromJson(json);
}

extension PopularTopPostDtoX on PopularTopPostDto {
  PopularTopPost toDomain() => PopularTopPost(
        id: id,
        title: title,
        viewCount: viewCount,
        createdAt: DateTime.parse(createdAt),
        likeCount: likeCount,
        commentCount: commentCount,
      );
}

// ---------------------------------------------------------------------------
// PopularBoardItemDto
// ---------------------------------------------------------------------------

@freezed
class PopularBoardItemDto with _$PopularBoardItemDto {
  const factory PopularBoardItemDto({
    required int boardId,
    required String boardName,
    String? boardSlug,
    required String boardType,
    required int postCount,
    PopularTopPostDto? topPost,
  }) = _PopularBoardItemDto;

  factory PopularBoardItemDto.fromJson(Map<String, dynamic> json) =>
      _$PopularBoardItemDtoFromJson(json);
}

extension PopularBoardItemDtoX on PopularBoardItemDto {
  PopularBoardItem toDomain() => PopularBoardItem(
        boardId: boardId,
        boardName: boardName,
        boardSlug: boardSlug,
        boardType: boardType,
        postCount: postCount,
        topPost: topPost?.toDomain(),
      );
}

// ---------------------------------------------------------------------------
// HomeDashboardDto
// ---------------------------------------------------------------------------

@freezed
class HomeDashboardDto with _$HomeDashboardDto {
  const factory HomeDashboardDto({
    required String weekday,
    @Default([]) List<HomeNoticeDto> notices,
    required TodayTimetableDto todayTimetable,
    @Default([]) List<PopularBoardItemDto> popularBoards,
  }) = _HomeDashboardDto;

  factory HomeDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDashboardDtoFromJson(json);
}

extension HomeDashboardDtoX on HomeDashboardDto {
  HomeDashboard toDomain() => HomeDashboard(
        weekday: weekday,
        notices: notices.map((n) => n.toDomain()).toList(),
        todayTimetable: todayTimetable.toDomain(),
        popularBoards: popularBoards.map((b) => b.toDomain()).toList(),
      );
}
