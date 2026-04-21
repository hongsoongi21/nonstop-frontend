import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_notice.freezed.dart';

@freezed
class HomeNotice with _$HomeNotice {
  const factory HomeNotice({
    required int id,
    String? title,
    required DateTime createdAt,
    required int boardId,
    required String boardName,
    String? boardSlug,
  }) = _HomeNotice;
}
