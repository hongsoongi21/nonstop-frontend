import 'package:freezed_annotation/freezed_annotation.dart';

part 'board.entity.freezed.dart';
part 'board.entity.g.dart';

enum BoardType {
  @JsonValue('GENERAL')
  general,
  @JsonValue('NOTICE')
  notice,
  @JsonValue('QNA')
  qna,
  @JsonValue('ANONYMOUS')
  anonymous,
}

@freezed
class Board with _$Board {
  const factory Board({
    required int id,
    required String name,
    required BoardType type,
    @Default(false) bool isSecret,
    required DateTime createdAt,
  }) = _Board;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}
