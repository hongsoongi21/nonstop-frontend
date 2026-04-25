import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_semester.freezed.dart';

@freezed
class HomeSemester with _$HomeSemester {
  const factory HomeSemester({
    required int id,
    required int year,
    required String type,
  }) = _HomeSemester;
}
