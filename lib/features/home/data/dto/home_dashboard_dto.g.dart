// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeNoticeDtoImpl _$$HomeNoticeDtoImplFromJson(Map<String, dynamic> json) =>
    _$HomeNoticeDtoImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      createdAt: json['createdAt'] as String,
      boardId: (json['boardId'] as num).toInt(),
      boardName: json['boardName'] as String,
      boardSlug: json['boardSlug'] as String?,
    );

Map<String, dynamic> _$$HomeNoticeDtoImplToJson(_$HomeNoticeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt,
      'boardId': instance.boardId,
      'boardName': instance.boardName,
      'boardSlug': instance.boardSlug,
    };

_$HomeSemesterDtoImpl _$$HomeSemesterDtoImplFromJson(
  Map<String, dynamic> json,
) => _$HomeSemesterDtoImpl(
  id: (json['id'] as num).toInt(),
  year: (json['year'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$$HomeSemesterDtoImplToJson(
  _$HomeSemesterDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'year': instance.year,
  'type': instance.type,
};

_$HomeTimetableEntryDtoImpl _$$HomeTimetableEntryDtoImplFromJson(
  Map<String, dynamic> json,
) => _$HomeTimetableEntryDtoImpl(
  id: (json['id'] as num).toInt(),
  subjectName: json['subjectName'] as String?,
  professor: json['professor'] as String?,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  place: json['place'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$$HomeTimetableEntryDtoImplToJson(
  _$HomeTimetableEntryDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'subjectName': instance.subjectName,
  'professor': instance.professor,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'place': instance.place,
  'color': instance.color,
};

_$TodayTimetableDtoImpl _$$TodayTimetableDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TodayTimetableDtoImpl(
  timetableId: (json['timetableId'] as num?)?.toInt(),
  semester: json['semester'] == null
      ? null
      : HomeSemesterDto.fromJson(json['semester'] as Map<String, dynamic>),
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map(
            (e) => HomeTimetableEntryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TodayTimetableDtoImplToJson(
  _$TodayTimetableDtoImpl instance,
) => <String, dynamic>{
  'timetableId': instance.timetableId,
  'semester': instance.semester,
  'entries': instance.entries,
};

_$PopularTopPostDtoImpl _$$PopularTopPostDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PopularTopPostDtoImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String?,
  viewCount: (json['viewCount'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  likeCount: (json['likeCount'] as num).toInt(),
  commentCount: (json['commentCount'] as num).toInt(),
);

Map<String, dynamic> _$$PopularTopPostDtoImplToJson(
  _$PopularTopPostDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'viewCount': instance.viewCount,
  'createdAt': instance.createdAt,
  'likeCount': instance.likeCount,
  'commentCount': instance.commentCount,
};

_$PopularBoardItemDtoImpl _$$PopularBoardItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PopularBoardItemDtoImpl(
  boardId: (json['boardId'] as num).toInt(),
  boardName: json['boardName'] as String,
  boardSlug: json['boardSlug'] as String?,
  boardType: json['boardType'] as String,
  postCount: (json['postCount'] as num).toInt(),
  topPost: json['topPost'] == null
      ? null
      : PopularTopPostDto.fromJson(json['topPost'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PopularBoardItemDtoImplToJson(
  _$PopularBoardItemDtoImpl instance,
) => <String, dynamic>{
  'boardId': instance.boardId,
  'boardName': instance.boardName,
  'boardSlug': instance.boardSlug,
  'boardType': instance.boardType,
  'postCount': instance.postCount,
  'topPost': instance.topPost,
};

_$HomeDashboardDtoImpl _$$HomeDashboardDtoImplFromJson(
  Map<String, dynamic> json,
) => _$HomeDashboardDtoImpl(
  weekday: json['weekday'] as String,
  notices:
      (json['notices'] as List<dynamic>?)
          ?.map((e) => HomeNoticeDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  todayTimetable: TodayTimetableDto.fromJson(
    json['todayTimetable'] as Map<String, dynamic>,
  ),
  popularBoards:
      (json['popularBoards'] as List<dynamic>?)
          ?.map((e) => PopularBoardItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$HomeDashboardDtoImplToJson(
  _$HomeDashboardDtoImpl instance,
) => <String, dynamic>{
  'weekday': instance.weekday,
  'notices': instance.notices,
  'todayTimetable': instance.todayTimetable,
  'popularBoards': instance.popularBoards,
};
